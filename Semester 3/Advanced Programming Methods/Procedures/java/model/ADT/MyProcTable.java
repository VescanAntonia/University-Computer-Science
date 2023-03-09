package model.ADT;

import javafx.util.Pair;
import model.exceptions.MyException;
import model.statement.IStmt;
import model.statement.IfStmt;
import model.value.Value;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MyProcTable implements MyIProcTable{
    private HashMap<String, Pair<List<String>, IStmt>> procTable;

    public MyProcTable(){

        this.procTable= new HashMap<>();
    }

    public void put(String key, Pair<List<String>,IStmt> value){
        synchronized (this){
        this.procTable.put(key,value);}

    }

    public boolean isDefined(String key){
        synchronized (this) {
            return this.procTable.containsKey(key);
        }
    }

    public Pair<List<String>,IStmt> lookUp(String key) throws MyException{
        synchronized (this){
        if(!isDefined(key)){
            throw new MyException(key + " is not defined.");
        }
        return this.procTable.get(key);}
    }

    public void update(String key, Pair<List<String>,IStmt> value) throws MyException{
        synchronized (this){
        if(!isDefined(key))
            throw new MyException(key + "is not defined");
        this.procTable.put(key,value);}

    }

    public void remove(String key) throws MyException{
        synchronized (this){
        if(!isDefined(key))
            throw new MyException(key + " not defined.");
        this.procTable.remove(key);}
    }

    public Collection<Pair<List<String>,IStmt>> values(){
        synchronized (this){
        return this.procTable.values();}
    }

    public Map<String,Pair<List<String>,IStmt>> getContent() {
        synchronized (this){
        return this.procTable;}
    }

    public String toString(){
        synchronized (this){
        return this.procTable.toString();
        }
    }
    @Override
    public MyIDictionary<String,Pair<List<String>,IStmt>> deepCopy() throws MyException {
        synchronized (this){
        MyIDictionary<String,Pair<List<String>,IStmt>> toReturn = new MyDictionary<>();
        for (String key: getContent().keySet())
            toReturn.put(key, lookUp(key));
        return toReturn;}
    }

}
