package com.example;

import java.util.HashSet;
import java.util.Set;

public class HashSetBasedRepository<T> implements InMemoryRepository<T>{
    private final Set<T> set;

    public HashSetBasedRepository() {
        this.set = new HashSet<T>();
    }

    @Override
    public void add(T elem) {
        set.add(elem);
    }

    @Override
    public boolean contains(T elem) {
        return set.contains(elem);
    }

    @Override
    public void remove(T elem) {
        set.remove(elem);
    }

    @Override
    public void clear() {
        set.clear();
    }
}
