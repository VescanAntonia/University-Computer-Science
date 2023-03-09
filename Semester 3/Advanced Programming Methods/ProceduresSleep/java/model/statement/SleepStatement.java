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

public class SleepStatement implements IStmt{

    private Integer number;

    public SleepStatement(Integer number){
        this.number=number;
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        return typeEnv;
    }
    @Override
    public PrgState execute(PrgState state)throws MyException {
        MyIStack<IStmt> stack=state.getExeStack();
        if (this.number!=0){
            stack.push(new SleepStatement(number-1));
            state.setExeStack(stack);
        }
        return null;
    }

    @Override
    public IStmt deepCopy(){
        return new SleepStatement(number);
    }
    @Override
    public String toString(){
        return String.format("sleep(%s)", number);
    }

}
