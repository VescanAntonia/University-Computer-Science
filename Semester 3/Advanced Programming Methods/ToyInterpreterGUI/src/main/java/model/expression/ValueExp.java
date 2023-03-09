package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.Type;
import model.value.Value;

public class ValueExp implements IExpression{
    Value e;
    public ValueExp(Value v){

        this.e=v;
    }

    public Type typecheck(MyIDictionary<String,Type>typeEnv) throws MyException{
        return e.getType();
    }
    @Override
    public Value eval(MyIDictionary<String,Value>tbl, MyIHeap heap) throws MyException{
        return this.e;
    }
    @Override
    public String toString(){

        return this.e.toString();
    }
    @Override
    public IExpression deepCopy(){

        return new ValueExp(e);
    }
}
