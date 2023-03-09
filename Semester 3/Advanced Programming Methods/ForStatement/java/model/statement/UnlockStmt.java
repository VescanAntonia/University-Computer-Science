package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyILockTable;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.Type;
import model.value.IntValue;
import model.value.Value;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class UnlockStmt implements IStmt{

    private final String var;
    private static final Lock lock= new ReentrantLock();

    public UnlockStmt(String var){
        this.var=var;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        if (typeEnv.lookUp(var).equals(new IntType()))
            return typeEnv;
        else
            throw new MyException("Var is not of IntType!");
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String,Value> symTable=state.getSymTable();
        MyILockTable lockTable=state.getLockTable();
        if (symTable.isDefined(var)){
            if (symTable.lookUp(var).getType().equals(new IntType())){
                IntValue fi=(IntValue) symTable.lookUp(var);
                Integer foundIndex=fi.getValue();
                if (lockTable.containsKey(foundIndex)) {
                    if (lockTable.get(foundIndex)==state.getId()){
                        lockTable.update(foundIndex,-1);
                    }
                }
            }
            else
                throw new MyException("Var is not of int type.");
        }
        else
            throw new MyException("Var is not defined on symTable.");
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new UnlockStmt(this.var);
    }
    @Override
    public String toString(){
        return String.format("Unlock(%s)",var);
    }

}
