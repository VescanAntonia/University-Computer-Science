package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.expression.RelationalExpression;
import model.expression.VarExp;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.Type;

public class ForStmt implements IStmt{

    private IExpression expression1,expression2,expression3;
    private final String var;
    private final IStmt statement;


    public ForStmt(String var, IExpression expression, IExpression expression2, IExpression expression3, IStmt stmt){
        this.expression1=expression;
        this.expression2=expression2;
        this.expression3=expression3;
        this.var=var;
        this.statement=stmt;
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        Type typeExpr=expression1.typecheck(typeEnv);
        Type typeExpr1=expression2.typecheck(typeEnv);
        Type typeExpr3=expression3.typecheck(typeEnv);
        if(typeExpr.equals(new IntType()) && typeExpr1.equals(new IntType()) && typeExpr3.equals(new IntType())){
            statement.typecheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new MyException("The condition of WHILE does not have the type Bool.");
    }

    @Override
    public PrgState execute(PrgState state)throws MyException {
        MyIStack<IStmt> stack=state.getExeStack();
        IStmt converted = new CompStmt(new AssignStmt("v", expression1),
                new WhileStmt(new RelationalExpression("<", new VarExp("v"), expression2),
                        new CompStmt(statement, new AssignStmt("v", expression3))));
        stack.push(converted);
        state.setExeStack(stack);
        return null;
    }

    @Override
    public ForStmt deepCopy(){
        return new ForStmt(this.var,this.expression1,this.expression2,this.expression3,this.statement.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("for(%s=%s; %s<%s; %s=%s) {%s}",var, expression1, var, expression2, var, expression3, statement);
    }

}
