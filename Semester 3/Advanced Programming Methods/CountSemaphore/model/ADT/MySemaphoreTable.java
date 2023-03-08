package model.ADT;

import javafx.util.Pair;
import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;
import java.util.List;

public class MySemaphoreTable implements MyISemaphoreTable{

    private HashMap<Integer, Pair<Integer,List<Integer>>> heap;
    private Integer freeLocation=0;

    public int newValue(){
        freeLocation+=1;
        return freeLocation;
    }

    public MySemaphoreTable(){
        this.heap=new HashMap<>();
    }

    public void put(Integer key, Pair<Integer, List<Integer>> value) throws MyException{
        synchronized (this){
            if(!heap.containsKey(key)){
                heap.put(key,value);
            }
            else
                throw new MyException(String.format("Semaphore table already contains the key %d!", key));
        }
    }

    public Pair<Integer,List<Integer>> get(Integer position) throws MyException {
        synchronized (this){
        if(heap.containsKey(position)){
            return heap.get(position);
        }
        else {
            throw new MyException(String.format("%d is not in the semaphore.",position));
        }
        }
    }

    public void update(Integer pos,Pair<Integer,List<Integer>> val) throws MyException{
        synchronized (this){
            if(heap.containsKey(pos)){
                heap.put(pos,val);
        }
        else{
            throw new MyException(String.format("%d not in the semaphore", pos));
        }
        }
    }
    public HashMap<Integer, Pair<Integer,List<Integer>>> getContent(){
        synchronized (this){
            return this.heap;
        }
    }

    public void setContent(HashMap<Integer,Pair<Integer,List<Integer>>>newMap){
        synchronized (this){
            this.heap=newMap;
        }
    }

    public boolean containsKey(Integer pos){
        synchronized (this){
            return this.heap.containsKey(pos);
        }
    }

    public String toString(){
        return this.heap.toString();

    }
}
