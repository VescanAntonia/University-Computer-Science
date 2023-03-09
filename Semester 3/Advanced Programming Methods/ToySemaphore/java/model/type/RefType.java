package model.type;

import model.value.RefValue;
import model.value.Value;

public class RefType implements Type {
    private Type inner;
    public RefType(Type inner){
        this.inner=inner;
    }

    public void setInner(Type inner) {
        this.inner = inner;
    }

    public Type getInner() {
        return inner;
    }
    @Override
    public boolean equals(Type anothertype){
        if (anothertype instanceof RefType)
            return inner.equals(((RefType) anothertype).getInner());
        else
            return false;
    }
    @Override
    public String toString(){
        return "Ref("+this.inner.toString()+")";
    }

    public Value defaultValue(){
        return new RefValue(0,this.inner);
    }
    @Override
    public Type deepCopy(){
        return new RefType(this.inner.deepCopy());
    }
}
