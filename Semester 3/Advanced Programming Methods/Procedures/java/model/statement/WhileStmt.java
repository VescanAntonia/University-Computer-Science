package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.BoolType;
import model.type.Type;
import model.value.BoolValue;
import model.value.Value;

public class WhileStmt implements IStmt{
    private IExpression expression;
    private IStmt statement;

    public WhileStmt(IExpression expression,IStmt statement){
        this.expression=expression;
        this.statement=statement;
    }
    @Override
    public MyIDictionary<String, Type>typecheck(MyIDictionary<String,Type>typeEnv) throws MyException{
        Type typeExpr=expression.typecheck(typeEnv);
        if(typeExpr.equals(new BoolType())){
            statement.typecheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new MyException("The condition of WHILE does not have the type Bool.");
    }

    @Override
    public PrgState execute(PrgState state)throws MyException {
        Value value=this.expression.eval(state.getSymTable().peek(),state.getHeap());
        MyIStack<IStmt> stack=state.getExeStack();
        if(value.getType().equals(new BoolType())){
            BoolValue boolValue=(BoolValue)value;
            if(boolValue.getValue()) {
                stack.push(this);
                stack.push(statement);
            }
        }
        else{
            throw new MyException(String.format("%s is not of BoolType", value));
        }
        return null;
    }

    @Override
    public WhileStmt deepCopy(){
        return new WhileStmt(this.expression.deepCopy(),this.statement.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("while(%s){%s}", expression, statement);
    }
}
