package com.example;

import java.util.ArrayList;
import java.util.List;

public class ArrayListBasedRepository<T> implements InMemoryRepository<T>{
    private final List<T> list;

    public ArrayListBasedRepository() {
        this.list = new ArrayList<T>();
    }

    @Override
    public void add(T elem){
        list.add(elem);
    }

    @Override
    public boolean contains(T elem){
        return list.contains(elem);
    }

    @Override
    public void remove(T elem){
        list.remove(elem);
    }

    @Override
    public void clear() {
        list.clear();
    }
}
