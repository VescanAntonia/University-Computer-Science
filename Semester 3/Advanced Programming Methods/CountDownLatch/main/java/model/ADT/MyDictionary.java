package model.ADT;

import model.exceptions.MyException;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class MyDictionary<K,V> implements MyIDictionary<K,V>{
    private HashMap<K,V> dictionary;
    public MyDictionary(){

        this.dictionary = new HashMap<K,V>();
    }
    public HashMap<K,V> getDictionary(){

        return this.dictionary;
    }
    public void put(K key, V value){
        this.dictionary.put(key,value);
    }
    public boolean isDefined(K key){

        return this.dictionary.containsKey(key);
    }

    public V lookUp(K key) throws MyException{
        if(!isDefined(key)){
            throw new MyException(key + " is not defined.");
        }
        return this.dictionary.get(key);
    }

    public void update(K key, V value) throws MyException{
        if(!isDefined(key))
            throw new MyException(key + "is not defined");
        this.dictionary.put(key,value);
    }
    public void remove(K key) throws MyException{
        if(!isDefined(key))
            throw new MyException(key + " not defined.");
        this.dictionary.remove(key);
    }

    public Collection<V>values(){
        return this.dictionary.values();
    }

    public Map<K, V> getContent() {
        return this.dictionary;
    }

    public String toString(){
        return this.dictionary.toString();
    }
    @Override
    public MyIDictionary<K,V> deepCopy() throws MyException {
        MyIDictionary<K,V> toReturn = new MyDictionary<>();
        for (K key: getContent().keySet())
            toReturn.put(key, lookUp(key));
        return toReturn;
    }

}
