package model.ADT;

import model.exceptions.MyException;

import java.util.List;
import java.util.Stack;

public interface MyIStack<T>{
    boolean isEmpty();
    Stack<T> getStk();
    List<T> getReversed();
    void push(T el);
    T pop() throws MyException;
    T peek() throws MyException;

    MyIStack<T> clone();
}
