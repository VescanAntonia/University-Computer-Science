package model.statement;

import javafx.util.Pair;
import model.ADT.MyICyclicBarrierTable;
import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.Type;
import model.value.IntValue;
import model.value.Value;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AwaitSmt implements IStmt{

    private final String varName;
    private final Lock lock=new ReentrantLock();

    public AwaitSmt(String varName){
        this.varName=varName;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        if (typeEnv.lookUp(varName).equals(new IntType()))
            return typeEnv;
        else
            throw new MyException("Var is not of type int!");
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyIHeap heap=state.getHeap();
        MyICyclicBarrierTable cyclicBarrierTable=state.getCyclicBarrierTable();

        if (symTable.isDefined(varName)) {
            IntValue f = (IntValue) symTable.lookUp(varName);
            int foundIndex = f.getValue();
            if (cyclicBarrierTable.containsKey(foundIndex)) {
                Pair<Integer, List<Integer>> foundBarrier = cyclicBarrierTable.get(foundIndex);
                int NL = foundBarrier.getValue().size();
                int N1 = foundBarrier.getKey();
                ArrayList<Integer> list = (ArrayList<Integer>) foundBarrier.getValue();
                if (N1 > NL) {
                    if (list.contains(state.getId()))
                        state.getExeStack().push(this);
                    else {
                        list.add(state.getId());
                        cyclicBarrierTable.update(foundIndex, new Pair<>(N1, list));
                        state.setCyclicBarrierTable(cyclicBarrierTable);
                    }
                }
            } else {
                throw new MyException("Index not in Barrier Table!");
            }
        } else {
            throw new MyException("Var is not defined!");
        }
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new AwaitSmt(this.varName);
    }
    @Override
    public String toString(){
        return String.format("Await(%s)",varName);
    }
}
