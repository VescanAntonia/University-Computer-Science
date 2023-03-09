package model.ADT;

import model.exceptions.MyException;

import java.util.HashMap;
import java.util.List;

public interface MyIToySemaphoreTable {
    int newValue();
    void put(Integer key, Tuple<Integer, List<Integer>, Integer> value) throws MyException;
    Tuple<Integer, List<Integer>, Integer>  get(Integer pos) throws MyException;
    void update(Integer pos,Tuple<Integer, List<Integer>, Integer> val) throws MyException;
    HashMap<Integer, Tuple<Integer, List<Integer>, Integer>> getContent();
    void setContent(HashMap<Integer, Tuple<Integer, List<Integer>, Integer>>newMap);
    boolean containsKey(Integer pos);
    String toString();
}
