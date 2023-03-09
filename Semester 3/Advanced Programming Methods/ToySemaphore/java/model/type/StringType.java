package model.type;

import model.value.StringValue;
import model.value.Value;

public class StringType implements Type{
    public boolean equals(Type anotherType){
        return anotherType instanceof StringType;
    }
    public Value defaultValue(){
        return new StringValue("");
    }
    public String toString(){
        return "string";
    }
    public Type deepCopy(){
        return new StringType();
    }
}
