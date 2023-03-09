package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.RefType;
import model.type.Type;
import model.value.RefValue;
import model.value.Value;

public class NewStmt implements IStmt{
    private final String varName;
    private final IExpression expression;

    public NewStmt(String varName,IExpression expression){
        this.varName=varName;
        this.expression=expression;
    }

    @Override
    public MyIDictionary<String,Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException{
        Type typeVar=typeEnv.lookUp(varName);
        Type typeExpr=expression.typecheck(typeEnv);
        if(typeVar.equals(new RefType(typeExpr)))
            return typeEnv;
        else
            throw new MyException("NEW statement: right hand side and left hand side have different types.");
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        MyIDictionary<String, Value> symTable=state.getSymTable();
        MyIHeap heap=state.getHeap();
        if((symTable.isDefined(this.varName))){
            Value varValue=symTable.lookUp(this.varName);
            if(varValue.getType() instanceof RefType){
                Value eval=this.expression.eval(symTable,heap);
                Type locationType=((RefValue)varValue).getLocationType();
                if(locationType.equals(eval.getType())){
                    int newPosition=heap.add(eval);
                    symTable.put(varName,new RefValue(newPosition,locationType));
                    state.setSymTable(symTable);
                    state.setHeap(heap);
                }
                else{
                    throw new MyException(varName+" is not of "+eval.getType());
                }
            }
            else{
                throw new MyException(varValue+" is not of RefType.");
            }
        }
        else{
            throw new MyException(this.varName+" is not defined into the SymTable.");
        }
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new NewStmt(this.varName, this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("New(%s,%s)",varName,expression);
    }
}
