package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.Type;
import model.value.Value;

public class VarExp implements IExpression{
    String id;
    public VarExp(String id){
        this.id=id;
    }

    public Type typecheck(MyIDictionary<String,Type>typeEnv) throws MyException{
        return typeEnv.lookUp(id);
    }
    @Override
    public Value eval(MyIDictionary<String,Value>tbl, MyIHeap heap)throws MyException{
        return tbl.lookUp(id);
    }
    @Override
    public String toString(){

        return this.id;
    }
    @Override
    public IExpression deepCopy(){

        return new VarExp(id);
    }
}
