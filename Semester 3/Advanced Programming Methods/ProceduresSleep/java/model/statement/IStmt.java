package model.statement;

import model.ADT.MyIDictionary;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.Type;

public interface IStmt {
    MyIDictionary<String,Type>typecheck(MyIDictionary<String, Type>typeEnv) throws MyException;
    PrgState execute(PrgState state) throws MyException;
    IStmt deepCopy();
}
