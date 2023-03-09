package model.ADT;

import model.exceptions.MyException;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public interface MyIDictionary<K,V>{
    boolean isDefined(K key);
    void update(K key, V value) throws MyException;
    HashMap<K,V> getDictionary();
    void put(K key, V value);
    void remove(K key) throws MyException;
    Collection<V> values();
    Map<K, V> getContent();
    V lookUp(K key) throws MyException;

    MyIDictionary<K,V> deepCopy() throws MyException;
}
