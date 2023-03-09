package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.BoolType;
import model.type.IntType;
import model.type.Type;
import model.value.BoolValue;
import model.value.IntValue;
import model.value.Value;

import java.util.Objects;

public class RelationalExpression implements IExpression{
    private String operator;
    private IExpression expression1;
    private IExpression expression2;

    public RelationalExpression(String op1,IExpression e1, IExpression e2){
        this.expression1=e1;
        this.expression2=e2;
        this.operator=op1;
    }
    public Type typecheck(MyIDictionary<String,Type>typeEnv)throws MyException{
        Type type1, type2;
        type1 = expression1.typecheck(typeEnv);
        type2 = expression2.typecheck(typeEnv);
        if (type1.equals(new IntType())) {
            if (type2.equals(new IntType())) {
                return new BoolType();
            } else
                throw new MyException("Second operand is not an integer.");
        } else
            throw new MyException("First operand is not an integer.");

    }

    public Value eval(MyIDictionary<String,Value> symTable, MyIHeap heap) throws MyException{
        Value v1, v2;
        v1 = this.expression1.eval(symTable,heap);
        if (v1.getType().equals(new IntType())) {
            v2 = this.expression2.eval(symTable,heap);
            if (v2.getType().equals(new IntType())) {
                IntValue i1 = (IntValue) v1;
                IntValue i2 = (IntValue) v2;
                int n1, n2;
                n1 = i1.getValue();
                n2 = i2.getValue();
                if (Objects.equals(this.operator,"<"))
                    return new BoolValue(n1<n2);
                else if (Objects.equals(this.operator,">"))
                    return new BoolValue(n1>n2);
                else if (Objects.equals(this.operator,"<="))
                    return new BoolValue(n1<=n2);
                else if(Objects.equals(this.operator,">="))
                    return new BoolValue(n1>=n2);
                else if (Objects.equals(this.operator,"=="))
                    return new BoolValue(n1==n2);
                else if(Objects.equals(this.operator,"!="))
                    return new BoolValue(n1!=n2);
            } else throw new MyException("second operand is not an integer");
        } else throw new MyException("first operand is not an integer");
        return null;
    }

    @Override
    public String toString(){

        return this.expression1.toString()+" "+this.operator+" "+this.expression2.toString();
    }

    @Override
    public IExpression deepCopy(){

        return new RelationalExpression(this.operator,expression1.deepCopy(),expression2.deepCopy());
    }
}
