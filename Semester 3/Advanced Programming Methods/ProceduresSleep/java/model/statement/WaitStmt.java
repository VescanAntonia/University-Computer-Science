package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.ValueExp;
import model.prgstate.PrgState;
import model.type.BoolType;
import model.type.Type;
import model.value.BoolValue;
import model.value.IntValue;
import model.value.Value;

public class WaitStmt implements IStmt{

    private final Integer number;
    public WaitStmt(Integer nr){
        this.number=nr;
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        return typeEnv;
    }

    @Override
    public PrgState execute(PrgState state)throws MyException {
        if (this.number!=0){
            MyIStack<IStmt> stack=state.getExeStack();
            stack.push(new CompStmt(new PrintStmt(new ValueExp(new IntValue(number))),new WaitStmt(number-1)));
        state.setExeStack(stack);
        }
        return null;
    }

    @Override
    public WaitStmt deepCopy(){
        return new WaitStmt(this.number);
    }
    @Override
    public String toString(){
        return String.format("wait(%s)", number);
    }

}
