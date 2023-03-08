package model.value;

import model.type.StringType;
import model.type.Type;

public class StringValue implements Value{
    public final String value;
    public StringValue(String value1){
        this.value=value1;
    }

    @Override
    public boolean equals(Object anotherValue){
        return anotherValue instanceof StringValue;
    }

    public String getValue(){
        return this.value;
    }

    public Type getType(){
        return new StringType();
    }

    public Value deepCopy(){
        return new StringValue(this.value);
    }

    public String toString(){
        return this.value;
    }
}
