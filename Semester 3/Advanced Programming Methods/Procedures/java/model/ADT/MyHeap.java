package model.ADT;

import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;

public class MyHeap implements MyIHeap{
    private HashMap<Integer, Value> heap;
    private Integer freeLocation;

    public int newValue(){
        freeLocation+=1;
        while(freeLocation==0|| heap.containsKey(freeLocation))
            freeLocation+=1;
        return freeLocation;
    }

    public MyHeap(){
        this.heap=new HashMap<>();
        this.freeLocation=1;
    }

    public int add(Value value){
        heap.put(this.freeLocation,value);
        Integer toReturn=freeLocation;
        freeLocation=this.newValue();
        return toReturn;
    }

    public Value get(Integer position) throws MyException{
        if(heap.containsKey(position)){
            return heap.get(position);
        }
        else {
            throw new MyException(String.format("%d is not in the map.",position));
        }
    }

    public void update(Integer pos,Value val) throws MyException{
        if(heap.containsKey(pos)){
            heap.put(pos,val);
        }
        else{
            throw new MyException(String.format("%d not in the heap", pos));
        }
    }
    public HashMap<Integer, Value> getContent(){
        return this.heap;
    }

    public void setContent(HashMap<Integer,Value>newMap){
        this.heap=newMap;
    }

    public boolean containsKey(Integer pos){
        return this.heap.containsKey(pos);
    }

    public String toString(){
        return this.heap.toString();
    }
}
