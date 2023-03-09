package model.statement;

import model.ADT.MyIDictionary;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.Type;

public class NopStmt implements IStmt {
    @Override
    public MyIDictionary<String, Type>typecheck(MyIDictionary<String,Type>typeEnv)throws MyException{
        return typeEnv;
    }
    @Override
    public PrgState execute(PrgState state){
        return null;
    }
    @Override
    public IStmt deepCopy(){

        return new NopStmt();
    }
    @Override
    public String toString(){
        return "NopStatement";
    }
}
