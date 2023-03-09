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

public class WriteHeap implements IStmt{
    private String varName;
    private IExpression expression;

    public WriteHeap(String varName,IExpression expression){
        this.varName=varName;
        this.expression=expression;
    }

    @Override
    public MyIDictionary<String, Type>typecheck(MyIDictionary<String,Type>typeEnv)throws MyException{
        if (typeEnv.lookUp(varName).equals(new RefType(expression.typecheck(typeEnv))))
            return typeEnv;
        else
            throw new MyException("WriteHeap: right hand side and left hand side have different types.");
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        MyIDictionary<String, Value> symTable=state.getSymTable().peek();
        MyIHeap heap=state.getHeap();
        if (symTable.isDefined(this.varName)){
            Value value=symTable.lookUp(this.varName);
            if(value instanceof RefValue){
                RefValue refValue=(RefValue) value;
                Value eval=this.expression.eval(symTable,heap);
                if(eval.getType().equals(refValue.getLocationType())){
                    heap.update(refValue.getAddress(),eval);
                    state.setHeap(heap);
                }
                else{
                    throw new MyException(String.format("%s not of %s", eval, refValue.getLocationType()));
                }
            }
            else{
                throw new MyException(String.format("%s not of RefType", value));
            }
        }
        else{
            throw new MyException(String.format("%s not present in the symTable", this.varName));
        }
        return null;
    }
    @Override
    public WriteHeap deepCopy(){
        return new WriteHeap(this.varName,this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("WriteHeap(%s,%s)",this.varName,this.expression);
    }
}
