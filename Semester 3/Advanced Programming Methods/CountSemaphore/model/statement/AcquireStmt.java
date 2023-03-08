package model.statement;

import javafx.util.Pair;
import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.ADT.MyISemaphoreTable;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.RefType;
import model.type.Type;
import model.value.IntValue;
import model.value.RefValue;
import model.value.Value;

import java.util.List;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AcquireStmt implements IStmt{
    private String varName;
    private final Lock lock=new ReentrantLock();

    public AcquireStmt(String varName){
        this.varName=varName;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        if (typeEnv.lookUp(varName).equals(new IntType()))
            return typeEnv;
        else
            throw new MyException(String.format("%s is not int!", varName));
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyIHeap heap=state.getHeap();
        MyISemaphoreTable semaphoreTable=state.getSemaphoreTable();
        if (symTable.isDefined(varName)) {
            if (symTable.lookUp(varName).getType().equals(new IntType())){
                IntValue fi = (IntValue) symTable.lookUp(varName);
                int foundIndex = fi.getValue();
                if (semaphoreTable.getContent().containsKey(foundIndex)) {
                    Pair<Integer, List<Integer>> foundSemaphore = semaphoreTable.get(foundIndex);
                    int NL = foundSemaphore.getValue().size();
                    int N1 = foundSemaphore.getKey();
                    if (N1 > NL) {
                        if (!foundSemaphore.getValue().contains(state.getId())) {
                            foundSemaphore.getValue().add(state.getId());
                            semaphoreTable.update(foundIndex, new Pair<>(N1, foundSemaphore.getValue()));
                        }
                    } else {
                        state.getExeStack().push(this);
                    }
                } else {
                    throw new MyException("Index not a key in the semaphore table!");
                }
            } else {
                throw new MyException("Index must be of int type!");
            }
        } else {
            throw new MyException("Index not in symbol table!");
        }
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new AcquireStmt(this.varName);
    }
    @Override
    public String toString(){
        return String.format("Acquire(%s)",this.varName);
    }

}
