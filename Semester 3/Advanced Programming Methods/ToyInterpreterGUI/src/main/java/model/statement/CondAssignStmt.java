package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.expression.VarExp;
import model.prgstate.PrgState;
import model.type.BoolType;
import model.type.Type;

public class CondAssignStmt implements IStmt{
    IExpression expression1,expression2,expression3;
    String variable;

    public CondAssignStmt(String variable, IExpression expression1, IExpression expression2, IExpression expression3){
        this.variable=variable;
        this.expression1=expression1;
        this.expression2=expression2;
        this.expression3=expression3;
    }
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type> typeEnv) throws MyException {
        Type variableType = new VarExp(variable).typecheck(typeEnv);
        Type typeExpr1=expression1.typecheck(typeEnv);
        Type typeExpr2=expression2.typecheck(typeEnv);
        Type typeExpr3=expression3.typecheck(typeEnv);
        if(typeExpr1.equals(new BoolType())&& typeExpr2.equals(variableType)&&typeExpr3.equals(variableType)){
            return typeEnv;
        }
        else
            throw new MyException("The conditional assignment is invalid!");
    }
    @Override
    public PrgState execute(PrgState state)throws MyException {
        MyIStack<IStmt> stack=state.getExeStack();
        IStmt converted = new IfStmt(expression1, new AssignStmt(variable, expression2), new AssignStmt(variable, expression3));
        stack.push(converted);
        state.setExeStack(stack);
        return null;
    }

    @Override
    public IStmt deepCopy(){
        return new CondAssignStmt(this.variable,this.expression1.deepCopy(),this.expression2.deepCopy(),this.expression3.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("%s=(%s)? %s: %s", variable, expression1, expression2, expression3);
    }
}
