package model.ADT;

import model.exceptions.MyException;

import java.util.ArrayList;
import java.util.List;

public class MyList<T> implements MyIList<T> {
    private List<T> list;
    public MyList(){

        this.list = new ArrayList<>();
    }
    public void add(T element){

        this.list.add(element);
    }
    public T pop() throws MyException {
        if(list.isEmpty())
            throw new MyException("The list is empty.");
        else
            return this.list.remove(0);
    }
    public void remove(T element){

        this.list.remove(element);
    }
    public void remove(int position){

        this.list.remove(position);
    }
    public int size(){

        return this.list.size();
    }
    public T get(int position){

        return this.list.get(position);
    }
    @Override
    public String toString() {

        return this.list.toString();
    }

    @Override
    public List<T> getList() {
        synchronized (this) {
            return list;
        }
    }

}
