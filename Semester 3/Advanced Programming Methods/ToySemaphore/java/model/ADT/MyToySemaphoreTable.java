package model.ADT;

import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;
import java.util.List;

public class MyToySemaphoreTable implements MyIToySemaphoreTable {
    private HashMap<Integer, Tuple<Integer, List<Integer>, Integer>> toySemaphoreTable;
    private Integer freeLocation=0;

    public int newValue(){
        freeLocation+=1;
        while(freeLocation==0|| toySemaphoreTable.containsKey(freeLocation))
            freeLocation+=1;
        return freeLocation;
    }

    public MyToySemaphoreTable(){
        this.toySemaphoreTable=new HashMap<>();
    }

    public void put(Integer key, Tuple<Integer, List<Integer>, Integer> value) throws MyException{
        synchronized (this) {
            if (!toySemaphoreTable.containsKey(key)) {
                toySemaphoreTable.put(key, value);
            } else {
                throw new MyException(String.format("Toy semaphore table already contains the key %d!", key));
            }
        }
    }

    public Tuple<Integer, List<Integer>, Integer> get(Integer key) throws MyException {
        synchronized (this) {
            if (toySemaphoreTable.containsKey(key)) {
                return toySemaphoreTable.get(key);
            } else {
                throw new MyException(String.format("Toy semaphore table doesn't contain the key %d!", key));
            }
        }
    }

    public void update(Integer pos,Tuple<Integer, List<Integer>, Integer> val) throws MyException{
        synchronized (this){
        if(toySemaphoreTable.containsKey(pos)){
            toySemaphoreTable.put(pos,val);
        }
        else{
            throw new MyException(String.format("%d not in the heap", pos));
        }
        }
    }
    public HashMap<Integer, Tuple<Integer, List<Integer>, Integer>> getContent(){
        synchronized (this){
            return this.toySemaphoreTable;
        }
    }

    public void setContent(HashMap<Integer, Tuple<Integer, List<Integer>, Integer>>newMap){
        synchronized (this){
            this.toySemaphoreTable=newMap;
        }
    }

    public boolean containsKey(Integer pos){
        synchronized (this){
            return this.toySemaphoreTable.containsKey(pos);
        }
    }

    public String toString(){
        synchronized (this){
            return this.toySemaphoreTable.toString();
        }
    }
}
