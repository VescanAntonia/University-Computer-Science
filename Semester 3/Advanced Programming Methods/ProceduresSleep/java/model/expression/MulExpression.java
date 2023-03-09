package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.IntType;
import model.type.Type;
import model.value.IntValue;
import model.value.Value;

public class MulExpression implements IExpression{

    IExpression expression1;
    IExpression expression2;


    public MulExpression(IExpression e1, IExpression e2){
        this.expression1=e1;
        this.expression2=e2;
    }

    public Type typecheck(MyIDictionary<String,Type> typeEnv) throws MyException {
        Type typ1,typ2;
        typ1=expression1.typecheck(typeEnv);
        typ2=expression2.typecheck(typeEnv);
        if (typ1.equals(new IntType())){
            if (typ2.equals(new IntType())){
                return new IntType();
            }
            else throw new MyException("second operand is not an integer");
        }
        else throw new MyException("first operand is not an integer");
    }

    public Value eval(MyIDictionary<String,Value> symTable, MyIHeap heap) throws MyException {
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
                return new IntValue((n1*n2)-(n1+n2));

            } else throw new MyException("second operand is not an integer");
        } else throw new MyException("first operand is not an integer");
//        IExpression converted = new ArithExp('-',
//                new ArithExp('*', expression1, expression2),
//                new ArithExp('+', expression1, expression2));
//        return converted.eval(table, heap);
    }
    public String toString(){

        return String.format("mul(%s,%s)", this.expression1.toString(),this.expression2.toString());}

    @Override
    public IExpression deepCopy(){

        return new MulExpression(expression1.deepCopy(),expression2.deepCopy());
    }
}
