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

public class LockStmt implements IStmt{

    private final String var;
    private static final Lock lock=new ReentrantLock();

    public LockStmt(String var){
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
        MyILockTable lockTable=state.getLockTable();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        if(symTable.isDefined(var))
        {
            if(symTable.lookUp(var).getType().equals(new IntType())){
                IntValue fi=(IntValue)symTable.lookUp(var);
                int fountIndex=fi.getValue();
                if(lockTable.containsKey(fountIndex)){
                    if (lockTable.get(fountIndex)==-1){
                        lockTable.update(fountIndex,state.getId());
                        state.setLockTable(lockTable);
                    }
                    else
                    {
                        state.getExeStack().push(this);
                    }
                }
                else
                    throw new MyException("FoundIndex not in lockTable.");
            }
            else
                throw new MyException("Var is not of int type.");

        }
        else
            throw new MyException("Variable not defined.");

        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new LockStmt(this.var);
    }
    @Override
    public String toString(){
        return String.format("Lock(%s)",var);
    }

}
