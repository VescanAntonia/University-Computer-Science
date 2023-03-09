package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.ADT.MyILockTable;
import model.ADT.MyLockTable;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.RefType;
import model.type.Type;
import model.value.IntValue;
import model.value.RefValue;
import model.value.Value;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class NewLockStmt implements IStmt{

    private final String var;
    private static final Lock lock = new ReentrantLock();
    public NewLockStmt(String var){
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
        MyIDictionary<String,Value> symTable=state.getSymTable();
        int freeAddress=lockTable.newValue();
        lockTable.add(freeAddress,-1);
        if (symTable.isDefined(var)&&symTable.lookUp(var).getType().equals(new IntType()))
            symTable.update(var,new IntValue(freeAddress));
        else
            throw new MyException("Var not declared!");
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new NewLockStmt(this.var);
    }
    @Override
    public String toString(){
        return String.format("NewLock(%s)",var);
    }


}
