package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.Type;
import model.value.Value;

public class AssignStmt implements IStmt {
    private String id;
    private IExpression exp;
    public AssignStmt(String id, IExpression exp){
        this.id = id;
        this.exp = exp;
    }
    public MyIDictionary<String,Type> typecheck(MyIDictionary<String,Type> typeEnv) throws MyException{
        Type typevar = typeEnv.lookUp(id);
        Type typexp = exp.typecheck(typeEnv);
        if (typevar.equals(typexp))
            return typeEnv;
        else
            throw new MyException("Assignment: right hand side and left hand side have different types ");
    }

    public PrgState execute(PrgState state) throws MyException {
        MyIStack<MyIDictionary<String,Value>> symbolTable = state.getSymTable();
        MyIDictionary<String,Value> currentSymTbl=symbolTable.peek();
        if (currentSymTbl.isDefined(id)){
            Value value = exp.eval(currentSymTbl,state.getHeap());
            Type typId=(currentSymTbl.lookUp(id)).getType();
            if(value.getType().equals(typId))
                currentSymTbl.update(id,value);
            else
                throw new MyException("Declared type of variable "+id+
                        "and type of the assigned expression do not match");

        }
        else {
            throw new MyException("the used variable" + id + "was not declared before");
        }
        state.setSymTable(symbolTable);
        return null;
    }
    @Override
    public IStmt deepCopy(){

        return new AssignStmt(id,exp.deepCopy());
    }
    public String toString(){
        return id+" = "+exp.toString();
    }
}
