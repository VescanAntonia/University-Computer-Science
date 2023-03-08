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

import java.util.ArrayList;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class CreateSemaphore implements IStmt{

    private final String varName;
    private final IExpression expression;

    private final Lock lock=new ReentrantLock();
    public CreateSemaphore(String varName,IExpression expression){
        this.varName=varName;
        this.expression=expression;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        if (typeEnv.lookUp(varName).equals(new IntType())) {
            if (expression.typecheck(typeEnv).equals(new IntType()))
                return typeEnv;
            else
                throw new MyException("Expression is not of int type!");
        } else {
            throw new MyException(String.format("%s is not of type int!", varName));
        }
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyISemaphoreTable semaphoreTable=state.getSemaphoreTable();
        MyIHeap heap=state.getHeap();
        IntValue nr= (IntValue) this.expression.eval(symTable,heap);
        int number=nr.getValue();
        int freeAddress=semaphoreTable.newValue();
        semaphoreTable.put(freeAddress,new Pair<>(number,new ArrayList<>()));
        if(symTable.isDefined(varName)&&symTable.lookUp(varName).getType().equals(new IntType()))
        {
            symTable.update(varName,new IntValue(freeAddress));
        }
        else {
            throw new MyException(String.format("Error for variable %s: not defined/does not have int type!", varName));
        }
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new CreateSemaphore(this.varName, this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("New(%s,%s)",varName,expression);
    }

}
