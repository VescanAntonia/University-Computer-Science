package com.example;

import java.util.Set;
import java.util.TreeSet;

public class TreeSetBasedRepository<T> implements InMemoryRepository<T> {
    private final Set<T> set;

    public TreeSetBasedRepository() {
        this.set = new TreeSet<T>();
    }

    public void add(T elem){
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

    public Set<T> getSet() {
        return set;
    }
}
