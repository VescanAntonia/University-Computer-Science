package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.ADT.MyIToySemaphoreTable;
import model.ADT.Tuple;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.Type;
import model.value.IntValue;
import model.value.Value;

import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ReleaseStmt implements IStmt{

    private final String varName;
    private final Lock lock=new ReentrantLock();

    public ReleaseStmt(String varName){
        this.varName=varName;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        return typeEnv;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyIToySemaphoreTable toySemaphoreTable=state.getToySemaphoreTable();
        if (symTable.isDefined(varName)) {
            if (symTable.lookUp(varName).getType().equals(new IntType())) {
                IntValue fi = (IntValue) symTable.lookUp(varName);
                int foundIndex = fi.getValue();
                if (toySemaphoreTable.containsKey(foundIndex)) {
                    Tuple<Integer, List<Integer>, Integer> foundSemaphore = toySemaphoreTable.get(foundIndex);
                    if (foundSemaphore.getSecond().contains(state.getId())) {
                        foundSemaphore.getSecond().remove((Integer) state.getId());
                    }
                    toySemaphoreTable.update(foundIndex, new Tuple<>(foundSemaphore.getFirst(), foundSemaphore.getSecond(), foundSemaphore.getThird()));
                } else {
                    throw new MyException("Index not found in the semaphore table!");
                }
            } else {
                throw new MyException("Index must be of int type!");
            }
        } else {
            throw new MyException("Index not found in the symbol table!");
        }
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new ReleaseStmt(this.varName);
    }
    @Override
    public String toString(){
        return String.format("Release(%s)",varName);
    }
}
