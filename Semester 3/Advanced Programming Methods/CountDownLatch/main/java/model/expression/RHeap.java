package model.expression;

import model.ADT.MyIDictionary;
import model.ADT.MyIHeap;
import model.exceptions.MyException;
import model.type.RefType;
import model.type.Type;
import model.value.RefValue;
import model.value.Value;

public class RHeap implements IExpression{
    private final IExpression expression;
    public RHeap(IExpression expression){
        this.expression=expression;
    }
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type type = expression.typecheck(typeEnv);
        if (type instanceof RefType) {
            RefType refType = (RefType) type;
            return refType.getInner();
        } else
            throw new MyException("The rH argument is not a RefType.");
    }

    @Override
    public Value eval(MyIDictionary<String,Value> symTable, MyIHeap heap) throws MyException {
        Value value=this.expression.eval(symTable,heap);
        if(value instanceof RefValue){
            RefValue refValue=(RefValue)value;
            if (heap.containsKey(refValue.getAddress()))
                return heap.get(refValue.getAddress());
            else
                throw new MyException("The address is not defined on the heap!");
        }
        else {
            throw new MyException(String.format("%s is not of RefType.",value));
        }
    }
    @Override
    public IExpression deepCopy(){
        return new RHeap(this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return String.format("ReadHeap(%s)",this.expression);
    }
}
