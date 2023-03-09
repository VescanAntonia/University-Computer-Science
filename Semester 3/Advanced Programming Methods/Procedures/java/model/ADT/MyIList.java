package model.ADT;

import model.exceptions.MyException;

import java.util.List;

public interface MyIList<T> {
    String toString();
    void add(T el);
    T pop()throws MyException;
    void remove(T el);
    int size();
    T get(int pos);
    void remove(int pos);
    List<T> getList();

}
