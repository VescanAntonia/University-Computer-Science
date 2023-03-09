package model.ADT;

import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;

public class MyLockTable implements MyILockTable{

    private HashMap<Integer, Integer> heap;
    private Integer freeLocation=0;


    public MyLockTable(){
        this.heap=new HashMap<>();
    }

    public int newValue(){
        synchronized (this){
            freeLocation+=1;
            return freeLocation;
        }
    }


    public void add(Integer key, Integer value) throws MyException{
        synchronized (this) {
            if (!heap.containsKey(key)) {
                heap.put(key, value);
            } else {
                throw new MyException(String.format("Lock table already contains the key %d!", key));
            }
        }
    }

    public Integer get(Integer position) throws MyException {
        synchronized (this){
            if(heap.containsKey(position)){
                return heap.get(position);
        }
            else {
                throw new MyException(String.format("%d is not in the table.",position));
        }
        }
    }

    public void update(Integer pos,Integer val) throws MyException{
        synchronized (this){
            if(heap.containsKey(pos)){
                heap.replace(pos,val);
            }
            else{
                throw new MyException(String.format("%d not in the table", pos));
            }
        }
    }
    public HashMap<Integer, Integer> getContent(){
        synchronized (this){
        return this.heap;
        }
    }

    public void setContent(HashMap<Integer,Integer>newMap){
        synchronized (this){
        this.heap=newMap;
        }
    }

    public boolean containsKey(Integer pos){
        synchronized (this) {
            return this.heap.containsKey(pos);
        }
    }

    public String toString(){
        return this.heap.toString();
    }

}
