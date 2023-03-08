package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.Type;
import model.value.Value;

public interface IExpression {
    Value eval(MyIDictionary<String, Value>tbl, MyIHeap heap) throws MyException;
    String toString();
    Type typecheck(MyIDictionary<String,Type>typeEnv) throws MyException;
    IExpression deepCopy();
}
