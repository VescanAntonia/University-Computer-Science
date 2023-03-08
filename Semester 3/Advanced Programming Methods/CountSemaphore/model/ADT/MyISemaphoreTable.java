package model.ADT;

import javafx.util.Pair;
import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;
import java.util.List;

public interface MyISemaphoreTable {
    int newValue();
    void put(Integer key,Pair<Integer,List<Integer>> value) throws MyException;
    Pair<Integer,List<Integer>> get(Integer pos) throws MyException;
    void update(Integer pos,Pair<Integer,List<Integer>> val) throws MyException;
    HashMap<Integer, Pair<Integer, List<Integer>>> getContent();
    void setContent(HashMap<Integer,Pair<Integer,List<Integer>>>newMap);
    boolean containsKey(Integer pos);
    String toString();
}
