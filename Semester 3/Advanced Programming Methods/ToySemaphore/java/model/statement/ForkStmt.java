package model.statement;

import model.ADT.MyDictionary;
import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.ADT.MyStack;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.Type;
import model.value.Value;

import java.util.Map;

public class ForkStmt implements IStmt{
    private IStmt statement;
    public ForkStmt(IStmt statement){
        this.statement=statement;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException{
        statement.typecheck(typeEnv.deepCopy());
        return typeEnv;
    }
    @Override
    public PrgState execute(PrgState state)throws MyException{
        MyIStack<IStmt>newStack=new MyStack<>();
        newStack.push(statement);
        MyIDictionary<String, Value> newSymTable=new MyDictionary<>();
        for(Map.Entry<String,Value> entry:state.getSymTable().getContent().entrySet()){
            newSymTable.put(entry.getKey(),entry.getValue().deepCopy());
        }
        return new PrgState(newStack,newSymTable,state.getOut(),state.getFileTable(),state.getHeap(),state.getToySemaphoreTable());
    }

    @Override
    public IStmt deepCopy(){
        return new ForkStmt(this.statement.deepCopy());
    }

    @Override
    public String toString(){
        return String.format("Fork(%s)", statement.toString());
    }
}
