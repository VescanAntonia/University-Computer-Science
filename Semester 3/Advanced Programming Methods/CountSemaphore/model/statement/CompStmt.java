package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.Type;

public class CompStmt implements IStmt {
    private IStmt first, second;
    public CompStmt(IStmt first, IStmt second){
        this.first=first;
        this.second=second;
    }
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type> typeEnv) throws MyException{
        return second.typecheck(first.typecheck(typeEnv));
    }
    public String toString(){
        return "("+this.first.toString()+";"+this.second.toString()+")";
    }
    public PrgState execute(PrgState state) throws MyException {
        MyIStack<IStmt> stk=state.getExeStack();
        stk.push(second);
        stk.push(first);
        state.setExeStack(stk);
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new CompStmt(first.deepCopy(),second.deepCopy());
    }
}
