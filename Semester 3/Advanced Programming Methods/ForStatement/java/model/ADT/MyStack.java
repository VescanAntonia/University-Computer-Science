package model.ADT;

import model.exceptions.MyException;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Stack;

public class MyStack <T> implements MyIStack<T> {
    private Stack<T> stack;
    public MyStack(){
        this.stack=new Stack<>();
    }

    public void push(T element){
        this.stack.push(element);
    }

    public T pop() throws MyException{
        if(!this.stack.isEmpty()){
            return this.stack.pop();
        }
        else{
            throw new MyException("Stack is empty!");
        }
    }

    public Stack<T> getStk(){
        return this.stack;
    }

    public boolean isEmpty(){
        return this.stack.isEmpty();
    }

    public List<T> getReversed(){
        List<T> list= Arrays.asList((T[]) stack.toArray());
        Collections.reverse(list);
        return list;
    }
    @Override
    public String toString(){
        return this.stack.toString();
    }
}
