package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.BoolType;
import model.type.Type;
import model.value.BoolValue;
import model.value.Value;

import java.util.Objects;

public class LogicExp implements IExpression{
    IExpression e1;
    IExpression e2;
    String operation;
    public LogicExp(IExpression e1, IExpression e2, String op){
        this.e1=e1;
        this.e2=e2;
        this.operation=op;
    }
    public Type typecheck(MyIDictionary<String,Type>typeEnv)throws MyException{
        Type type1, type2;
        type1 = e1.typecheck(typeEnv);
        type2 = e2.typecheck(typeEnv);
        if (type1.equals(new BoolType())) {
            if (type2.equals(new BoolType())) {
                return new BoolType();
            } else
                throw new MyException("Second operand is not a boolean.");
        } else
            throw new MyException("First operand is not a boolean.");
    }
    @Override
    public Value eval(MyIDictionary<String,Value>tbl, MyIHeap heap) throws MyException{
        Value v1,v2;
        v1=e1.eval(tbl,heap);
        if(v1.getType().equals(new BoolType())){
            v2=e2.eval(tbl,heap);
            if(v2.getType().equals(new BoolType())){
                BoolValue i1=(BoolValue) v1;
                BoolValue i2=(BoolValue)v2;
                boolean n1,n2;
                n1=i1.getValue();
                n2=i2.getValue();
                if(Objects.equals(this.operation,"and")){
                    return new BoolValue(n1&&n2);
                }
                else if(Objects.equals(this.operation,"or")){
                    return new BoolValue((n1||n2));
                }
            }else{
                throw new MyException("Second operand not boolean.");
            }
        }else {
            throw new MyException("First operand is not a boolean.");
        }
        return null;
    }

    @Override
    public String toString(){

        return this.e1.toString()+" "+this.operation+this.e2.toString();
    }
    @Override
    public IExpression deepCopy(){

        return new LogicExp(this.e1.deepCopy(),this.e2.deepCopy(),operation);
    }
}
