package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.expression.NotExpr;
import model.prgstate.PrgState;
import model.type.BoolType;
import model.type.Type;
import model.value.BoolValue;
import model.value.Value;

public class RepeatUntilStmt implements IStmt{
    private final IExpression expression;
    private final IStmt statement;

    public RepeatUntilStmt(IStmt statement,IExpression expression){
        this.statement=statement;
        this.expression=expression;
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        Type typeExpr=expression.typecheck(typeEnv);
        if(typeExpr.equals(new BoolType())){
            statement.typecheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new MyException("The condition of Until does not have the type Bool.");
    }

    @Override
    public PrgState execute(PrgState state)throws MyException {
        MyIStack<IStmt> stack=state.getExeStack();
        IStmt converted = new CompStmt(statement, new WhileStmt(new NotExpr(expression), statement));
        stack.push(converted);
        state.setExeStack(stack);
        return null;
    }

    @Override
    public IStmt deepCopy(){
        return new RepeatUntilStmt(this.statement.deepCopy(),this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("Repeat{%s}Until(%s)", statement,expression);
    }

}
