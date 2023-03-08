package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.ADT.MyILatchTable;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.RefType;
import model.type.Type;
import model.value.IntValue;
import model.value.RefValue;
import model.value.Value;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class NewLatch implements IStmt{

    private final String variable;
    private final IExpression expression;
    private final Lock lock= new ReentrantLock();

    public NewLatch(String varName,IExpression expression){
        this.variable=varName;
        this.expression=expression;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException {
        lock.lock();
        if(typeEnv.lookUp(variable).equals(new IntType())){
            if(expression.typecheck(typeEnv).equals(new IntType())){
                return typeEnv;
            }
            else{
                throw new MyException("Expression does not have int type!");
            }
        }
        else{
            throw new MyException(String.format("%s is not of int type!",variable));

        }
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        lock.lock();
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyIHeap heap=state.getHeap();
        MyILatchTable latchTable=state.getLatchTable();
        IntValue nr=(IntValue)(expression.eval(symTable,heap));
        int number=nr.getValue();
        int freeAddress=latchTable.getFreeAddress();
        latchTable.put(freeAddress,number);
        if(symTable.isDefined(this.variable)){
            symTable.update(variable,new IntValue(freeAddress));
        }
        else{
            throw new MyException(String.format("%s is not defined in the symbol table!", variable));
        }

        lock.unlock();
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new NewLatch(this.variable, this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("NewLatch(%s,%s)",variable,expression);
    }

}
