package model.ADT;

import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;


public interface MyILockTable {
    int newValue();
    void add(Integer key, Integer value) throws MyException;
    Integer get(Integer pos) throws MyException;
    void update(Integer pos,Integer val) throws MyException;
    HashMap<Integer, Integer> getContent();
    void setContent(HashMap<Integer,Integer>newMap);
    boolean containsKey(Integer pos);
    String toString();
}
