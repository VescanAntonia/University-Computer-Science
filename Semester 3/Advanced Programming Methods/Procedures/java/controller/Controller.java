package controller;

import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.value.RefValue;
import model.value.Value;
import repository.IRepository;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;
import java.util.stream.Stream;

class Pair {
    final PrgState first;
    final MyException second;

    public Pair(PrgState first, MyException second) {
        this.first = first;
        this.second = second;
    }
}
public class Controller {
    IRepository repository;
    ExecutorService executor;
    boolean displayFlag=false;
    public Controller(IRepository repo){
        this.repository=repo;
    }
    public void setDisplayFlag(boolean value){
        this.displayFlag=value;
    }
//    public PrgState oneStep(PrgState state) throws MyException{
//        MyIStack<IStmt>stk=state.getExeStack();
//        if(stk.isEmpty())
//            throw new MyException("PrgState stack is empty.");
//        IStmt crtStmt=stk.pop();
//        state.setExeStack(stk);
//        return crtStmt.execute(state);
//    }

    public void oneStepForAllPrg(List<PrgState>prgList) throws InterruptedException,IOException,MyException{
        prgList.forEach(programState -> {         //executes one step for each thread
            try {
                display(programState);
                repository.logPrgStateExec(programState);
            } catch (IOException|MyException e) {
                System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
            }
        });
        List<Callable<PrgState>> callList = prgList.stream()
                .map((PrgState p) -> (Callable<PrgState>) (p::oneStep))
                .collect(Collectors.toList());

        List<PrgState> newProgramList = executor.invokeAll(callList).stream()
                .map(future -> {
                    try {
                        return future.get();
                    } catch (ExecutionException | InterruptedException e) {
                        System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
                    }
                    return null;
                })
                .filter(Objects::nonNull)
                .collect(Collectors.toList());

        prgList.addAll(newProgramList);

        prgList.forEach(programState -> {
            try {
                repository.logPrgStateExec(programState);
            } catch (IOException | MyException e) {
                System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
            }
        });
        repository.setProgramList(prgList);
    }

    public void allStep() throws IOException, MyException,InterruptedException{
        executor = Executors.newFixedThreadPool(2);
        //remove the completed programs
        List<PrgState> prgList=removeCompletedProgram(repository.getProgramList());
        while(prgList.size() > 0){
            //oneStepForAllPrg(prgList);
            conservativeGarbageCollector(prgList);
            oneStepForAllPrg(prgList);
            //remove the completed programs
            prgList=removeCompletedProgram(repository.getProgramList());
        }
        executor.shutdownNow();
        repository.setProgramList(prgList);

//        PrgState prg= this.repository.getCurrentState();
//        this.repository.logPrgStateExec();
//        //this.repository.getProgramStates();
//        this.displayStates();
//        while(!prg.getExeStack().isEmpty()){
//            this.oneStep(prg);
//            this.repository.logPrgStateExec();
//            prg.getHeap().setContent((HashMap<Integer, Value>)safeGarbageCollector(
//                    getAddrFromSymTable(prg.getSymTable().getContent().values()),
//                    prg.getHeap().getContent()));
//            //this.repository.getProgramStates();
//            this.displayStates();
//            this.repository.logPrgStateExec();
//        }
    }

    public void conservativeGarbageCollector(List<PrgState> programStates) throws MyException {

        List<Integer> symTableAddresses = Objects.requireNonNull(programStates.stream()
                        .map(p -> {
                            try {
                                return getAddrFromSymTable(p.getSymTable().peek().values());
                            } catch (MyException e) {
                                throw new RuntimeException(e);
                            }
                        })
                        .map(Collection::stream)
                        .reduce(Stream::concat).orElse(null))
                        .collect(Collectors.toList());
        programStates.forEach(p -> {
            p.getHeap().setContent((HashMap<Integer, Value>) safeGarbageCollector(symTableAddresses, getAddrFromHeap(p.getHeap().getContent().values()), p.getHeap().getContent()));
        });
    }

    private void display(PrgState programState) {
        if (displayFlag) {
            System.out.println(programState.toString());
        }
    }

//    public void displayStates(){
//        if(this.displayFlag){
//            System.out.println(this.repository.getCurrentState().toString());
//        }
//    }

    public void oneStep() throws MyException, InterruptedException,IOException {
        executor = Executors.newFixedThreadPool(2);
        List<PrgState> programStates = removeCompletedProgram(repository.getProgramList());
        oneStepForAllPrg(programStates);
        conservativeGarbageCollector(programStates);
        //programStates = removeCompletedPrg(repository.getProgramList());
        executor.shutdownNow();
        //repository.setProgramStates(programStates);
    }

    Map<Integer,Value> unsafeGarbageCollector(List<Integer> symTableAddr, Map<Integer,Value> heap){
        return heap.entrySet().stream().filter(e -> symTableAddr.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey,Map.Entry::getValue));
    }
//    Map<Integer,Value>safeGarbageCollector(List<Integer> symTableAddr, Map<Integer,Value> heap){
//        return heap.entrySet().stream().filter(e -> symTableAddr.contains(e.getKey())||heap.containsKey(e.getKey()))
//                .collect(Collectors.toMap(Map.Entry::getKey,Map.Entry::getValue));
//    }

    public Map<Integer, Value> safeGarbageCollector(List<Integer> symTableAddr, List<Integer> heapAddr, Map<Integer, Value> heap) {
        return heap.entrySet().stream()
                .filter(e -> ( symTableAddr.contains(e.getKey()) || heapAddr.contains(e.getKey())))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }
    List<Integer> getAddrFromSymTable(Collection<Value> symTableValues){
        return symTableValues.stream()
                .filter(v-> v instanceof RefValue)
                .map(v-> {RefValue v1 = (RefValue)v;return v1.getAddress();}).collect(Collectors.toList());
    }

    public List<Integer> getAddrFromHeap(Collection<Value> heapValues) {
        return heapValues.stream()
                .filter(v -> v instanceof RefValue)
                .map(v -> {RefValue v1 = (RefValue) v; return v1.getAddress();})
                .collect(Collectors.toList());
    }

    public List<PrgState> removeCompletedProgram(List<PrgState>inPrgList){
        return inPrgList.stream().filter(p->!p.isNotCompleted()).collect(Collectors.toList());
    }

    public List<PrgState> getProgramStates() {
        return this.repository.getProgramList();
    }

    public void setProgramStates(List<PrgState> programStates) {
        this.repository.setProgramStates(programStates);
    }
}
