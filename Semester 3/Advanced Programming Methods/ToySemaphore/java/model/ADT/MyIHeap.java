package model.ADT;

import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;

public interface MyIHeap {
    int newValue();
    int add(Value value);
    Value get(Integer pos) throws MyException;
    void update(Integer pos,Value val) throws MyException;
    HashMap<Integer, Value> getContent();
    void setContent(HashMap<Integer,Value>newMap);
    boolean containsKey(Integer pos);
    String toString();
}
