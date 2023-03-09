package model.statement;

import model.ADT.*;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.Type;
import model.value.Value;

import java.util.List;

public class CallProcStatement implements IStmt{
    private List<IExpression> expression;
    private final String procedureName;
    public CallProcStatement(String procName,List<IExpression> expression){
        this.procedureName=procName;
        this.expression=expression;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv) throws MyException {
        return typeEnv;
    }
    @Override
    public PrgState execute(PrgState state)throws MyException{
        MyIDictionary<String,Value> symTable=state.getTopSymTable();
        MyIHeap heap=state.getHeap();
        MyIProcTable procTable=state.getProcTable();
        if (procTable.isDefined(procedureName)){
            List<String> variables=procTable.lookUp(procedureName).getKey();
            IStmt statement=procTable.lookUp(procedureName).getValue();
            MyIDictionary<String,Value> newSymTable=new MyDictionary<>();
            for(String var:variables){
                int ind=variables.indexOf(var);
                newSymTable.put(var,expression.get(ind).eval(symTable,heap));

            }
            state.getSymTable().push(newSymTable);
            state.getExeStack().push(new ReturnStatement());
            state.getExeStack().push(statement);
        }
        else
        {
            throw new MyException("Procedure not defined!");
        }
        return null;

    }

    @Override
    public IStmt deepCopy(){
        return new CallProcStatement(procedureName,expression);
    }

    @Override
    public String toString(){
        return String.format("Call %s%s", procedureName,expression.toString());
    }

}
