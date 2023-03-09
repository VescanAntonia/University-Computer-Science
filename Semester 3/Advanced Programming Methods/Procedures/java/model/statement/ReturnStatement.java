package model.statement;

import model.ADT.*;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.Type;
import model.value.Value;

import java.util.List;

public class ReturnStatement implements IStmt{
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        return typeEnv;
    }
    @Override
    public PrgState execute(PrgState state)throws MyException{
        state.getExeStack().pop();
        return null;
    }

    @Override
    public IStmt deepCopy(){
        return new ReturnStatement();
    }

    @Override
    public String toString(){
        return "Return";
    }

}
