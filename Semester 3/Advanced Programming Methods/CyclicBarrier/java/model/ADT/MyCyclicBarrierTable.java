package model.ADT;

import javafx.util.Pair;
import model.exceptions.MyException;
import model.value.Value;

import java.util.HashMap;
import java.util.List;

public class MyCyclicBarrierTable implements MyICyclicBarrierTable{

    private HashMap<Integer, Pair<Integer, List<Integer>>> myBarrierTable;
    private Integer freeLocation=0;

    public int newValue(){
        freeLocation+=1;
        while(freeLocation==0|| myBarrierTable.containsKey(freeLocation))
            freeLocation+=1;
        return freeLocation;
    }

    public MyCyclicBarrierTable(){
        this.myBarrierTable=new HashMap<>();
    }

    public void put(Integer key,Pair<Integer, List<Integer>> value)throws MyException{
        synchronized (this) {
            if (!myBarrierTable.containsKey(key)) {
                myBarrierTable.put(key, value);
            } else {
                throw new MyException(String.format("Barrier table already contains the key %d!", key));
            }
        }
    }

    public Pair<Integer, List<Integer>> get(Integer position) throws MyException {
        synchronized (this) {
            if (myBarrierTable.containsKey(position)) {
                return myBarrierTable.get(position);
            } else {
                throw new MyException(String.format("Barrier table doesn't contain the key %d!", position));
            }
        }
    }

    public void update(Integer pos,Pair<Integer, List<Integer>> val) throws MyException{
        synchronized (this) {
            if (myBarrierTable.containsKey(pos)) {
                myBarrierTable.replace(pos, val);
            } else {
                throw new MyException(String.format("Barrier table doesn't contain key %d!", pos));
            }
        }
    }

    public HashMap<Integer, Pair<Integer, List<Integer>>>  getContent(){
        synchronized (this) {
            return myBarrierTable;
        }
    }

    public void setContent(HashMap<Integer, Pair<Integer, List<Integer>>> newMap){
        synchronized (this) {
            this.myBarrierTable= newMap;
        }
    }

    public boolean containsKey(Integer pos){
        synchronized (this) {
            return myBarrierTable.containsKey(pos);
        }
    }

    public String toString(){
        return this.myBarrierTable.toString();
    }

}
