package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.expression.RelationalExpression;
import model.prgstate.PrgState;
import model.type.BoolType;
import model.type.Type;
import model.value.BoolValue;
import model.value.Value;

public class SwitchStmt implements IStmt{
    private final IExpression expression,expression1,expression2;
    private final IStmt statement1,statement2,statement3;

    public SwitchStmt(IExpression expression,IExpression expression1,IStmt statement1,IExpression expression2,IStmt statement2,IStmt statement3){
        this.expression=expression;
        this.expression1=expression1;
        this.statement1=statement1;
        this.expression2=expression2;
        this.statement2=statement2;
        this.statement3=statement3;
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        Type typeExpr=expression.typecheck(typeEnv);
        Type typeExpr1=expression1.typecheck(typeEnv);
        Type typeExpr2=expression2.typecheck(typeEnv);
        if(typeExpr.equals(typeExpr1)&&typeExpr.equals(typeExpr2)){
            statement1.typecheck(typeEnv.deepCopy());
            statement2.typecheck(typeEnv.deepCopy());
            statement3.typecheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new MyException("The expression types don't match in the switch statement!");
    }

    @Override
    public PrgState execute(PrgState state)throws MyException {
        MyIStack<IStmt> stack=state.getExeStack();
        IStmt converted = new IfStmt(new RelationalExpression("==", expression, expression1),
                statement1, new IfStmt(new RelationalExpression("==", expression, expression2), statement2, statement3));
        stack.push(converted);
        state.setExeStack(stack);
        return null;
    }

    @Override
    public SwitchStmt deepCopy(){
        return new SwitchStmt(expression.deepCopy(), expression1.deepCopy(), statement1.deepCopy(), expression2.deepCopy(), statement2.deepCopy(), statement3.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("switch(%s){(case(%s): %s)(case(%s): %s)(default: %s)}", expression, expression1, statement1, expression2, statement2, statement3);

    }

}
