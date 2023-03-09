package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.ADT.MyIToySemaphoreTable;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.ADT.*;
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

public class NewSemaphoreStmt implements IStmt{
    private final String varName;
    private final IExpression expression1,expression2;
    private final Lock lock=new ReentrantLock();

    public NewSemaphoreStmt(String varName,IExpression expression1,IExpression expression2){
        this.varName=varName;
        this.expression1=expression1;
        this.expression2=expression2;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        return typeEnv;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyIHeap heap=state.getHeap();
        MyIToySemaphoreTable toySemaphoreTable=state.getToySemaphoreTable();
        IntValue nr1 = (IntValue) (expression1.eval(symTable, heap));
        IntValue nr2 = (IntValue) (expression2.eval(symTable, heap));
        int number1 = nr1.getValue();
        int number2 = nr2.getValue();
        int freeAddress = toySemaphoreTable.newValue();
        toySemaphoreTable.put(freeAddress, new Tuple<>(number1, new ArrayList<>(), number2));
        if (symTable.isDefined(varName) && symTable.lookUp(varName).getType().equals(new IntType()))
            symTable.update(varName, new IntValue(freeAddress));
        else
            throw new MyException(String.format("%s in not defined in the symbol table!", varName));
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new NewSemaphoreStmt(this.varName, this.expression1.deepCopy(),this.expression2.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("NewSemaphore(%s,%s,%s)",varName,expression1,expression2);
    }

}
