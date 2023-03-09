package model.statement;

import javafx.util.Pair;
import model.ADT.MyICyclicBarrierTable;
import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
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

public class NewBarrierStmt implements IStmt{
    private final String varName;
    private final IExpression expression;
    private final Lock lock=new ReentrantLock();

    public NewBarrierStmt(String varName,IExpression expression){
        this.varName=varName;
        this.expression=expression;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        if (typeEnv.lookUp(varName).equals(new IntType()))
            if (expression.typecheck(typeEnv).equals(new IntType()))
                return typeEnv;
            else
                throw new MyException("Expression is not of type int!");
        else
            throw new MyException("Variable is not of type int!");
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyIHeap heap=state.getHeap();
        MyICyclicBarrierTable cyclicBarrierTable=state.getCyclicBarrierTable();
        IntValue number = (IntValue) (expression.eval(symTable, heap));
        int nr = number.getValue();
        int freeAddress = cyclicBarrierTable.newValue();
        cyclicBarrierTable.put(freeAddress, new Pair<>(nr, new ArrayList<>()));
        if(symTable.isDefined(varName)){
            symTable.update(varName,new IntValue(freeAddress));
        }
        else
            throw new MyException(String.format("%s is not defined in the symbol table!", varName));
        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new NewBarrierStmt(this.varName, this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("NewBarrier(%s,%s)",varName,expression);
    }

}
