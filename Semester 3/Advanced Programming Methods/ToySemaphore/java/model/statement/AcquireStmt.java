package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.ADT.MyIToySemaphoreTable;
import model.ADT.Tuple;
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

public class AcquireStmt implements IStmt{
    private final String varName;
    private final Lock lock=new ReentrantLock();

    public AcquireStmt(String varName){
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
        MyIHeap heap=state.getHeap();
        if (symTable.isDefined(varName)) {
            if (symTable.lookUp(varName).getType().equals(new IntType())) {
                IntValue fi = (IntValue) symTable.lookUp(varName);
                int foundIndex = fi.getValue();
                if (toySemaphoreTable.containsKey(foundIndex)) {
                    Tuple<Integer, List<Integer>, Integer> foundSemaphore = toySemaphoreTable.get(foundIndex);
                    int NL = foundSemaphore.getSecond().size();
                    int N1 = foundSemaphore.getFirst();
                    int N2 = foundSemaphore.getThird();
                    if ((N1 - N2) > NL) {
                        if (!foundSemaphore.getSecond().contains(state.getId())) {
                            foundSemaphore.getSecond().add(state.getId());
                            toySemaphoreTable.update(foundIndex, new Tuple<>(N1, foundSemaphore.getSecond(), N2));
                        }
                    } else {
                        state.getExeStack().push(this);
                    }
                } else {
                    throw new MyException("Index is not in the semaphore table!");
                }
            } else {
                throw new MyException("Index does not have the int type!");
            }
        } else
            throw new MyException("Index not in the symbol table!");
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new AcquireStmt(this.varName);
    }
    @Override
    public String toString(){
        return String.format("Acquire(%s)",varName);
    }
}
