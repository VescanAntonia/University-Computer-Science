package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyILatchTable;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.BoolType;
import model.type.IntType;
import model.type.Type;
import model.value.BoolValue;
import model.value.IntValue;
import model.value.Value;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class AwaitStmt implements IStmt{

    private final String variable;
    private final Lock lock=new ReentrantLock();

    public AwaitStmt(String variable){
        this.variable=variable;
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        if (typeEnv.lookUp(variable).equals(new IntType()))
            return typeEnv;
        else
            throw new MyException(String.format("%s is not of int type!", variable));
    }

    @Override
    public PrgState execute(PrgState state)throws MyException {
        lock.lock();
        MyIStack<IStmt> stack=state.getExeStack();
        MyIDictionary<String,Value> symTable=state.getSymTable();
        MyILatchTable latchTable=state.getLatchTable();
        if(symTable.isDefined(variable)){
            IntValue fi=(IntValue)symTable.lookUp(variable);
            int foundIndex=fi.getValue();
            if(latchTable.containsKey(foundIndex)){
                if(latchTable.get(foundIndex)!=0){
                    state.getExeStack().push(this);
                }
            }
            else throw new MyException("Index not found in the latch table.");
        }
        else throw new MyException("The var not defined in the symTable.");
        lock.unlock();
        return null;
    }

    @Override
    public AwaitStmt deepCopy(){
        return new AwaitStmt(this.variable);
    }
    @Override
    public String toString(){
        return String.format("Await(%s)",variable);
    }

}
