package model.value;

import model.type.IntType;
import model.type.Type;

public class IntValue implements Value{
    private final int value;
    public IntValue(int value){
        this.value=value;
    }
    public int getValue(){
        return this.value;
    }
    @Override
    public boolean equals(Object anotherValue){
        return anotherValue instanceof IntValue;
    }
    @Override
    public String toString(){
        return String.format("%d", this.value);
    }
    @Override
    public Type getType(){
        return new IntType();
    }
    @Override
    public Value deepCopy(){
        return new IntValue(this.value);
    }

}
