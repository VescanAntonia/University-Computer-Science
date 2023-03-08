package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.Type;
import model.value.BoolValue;
import model.value.Value;

public class NotExpr implements IExpression{
    private final IExpression expression;

    public NotExpr(IExpression expression) {
        this.expression = expression;
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        return expression.typecheck(typeEnv);
    }

    @Override
    public Value eval(MyIDictionary<String, Value> table, MyIHeap heap) throws MyException {
        BoolValue value = (BoolValue) expression.eval(table, heap);
        if (!value.getValue())
            return new BoolValue(true);
        else
            return new BoolValue(false);
    }

    @Override
    public IExpression deepCopy() {
        return new NotExpr(expression.deepCopy());
    }

    @Override
    public String toString() {
        return String.format("!(%s)", expression);
    }
}
