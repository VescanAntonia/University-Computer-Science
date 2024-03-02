package com.example;

import it.unimi.dsi.fastutil.objects.ObjectOpenHashSet;

public class FastUtilRepository<T> implements InMemoryRepository<T> {
    private final ObjectOpenHashSet<T> set;

    public FastUtilRepository() {
        this.set = new ObjectOpenHashSet<>();
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
