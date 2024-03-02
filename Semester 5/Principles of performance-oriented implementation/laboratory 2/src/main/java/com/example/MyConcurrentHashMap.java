package com.example;
//import it.unimi.dsi.fastutil.objects.Object2ObjectOpenHashMap;
//import gnu.trove.map.TObjectObjectMap;
//import gnu.trove.map.hash.TObjectObjectHashMap;

import java.util.concurrent.ConcurrentHashMap;

public class MyConcurrentHashMap<T> implements InMemoryRepository<T>{
    private final ConcurrentHashMap<T,Boolean> concurrentHashMap;
    public MyConcurrentHashMap() {
        concurrentHashMap=new ConcurrentHashMap<>();
    }

    @Override
    public void add(T elem) {
        concurrentHashMap.put(elem,true);
    }

    public boolean contains(T key){
        return concurrentHashMap.containsKey(key);
    }

    @Override
    public void remove(T elem) {
        concurrentHashMap.remove(elem);
    }

    @Override
    public void clear() {
        concurrentHashMap.clear();
    }

}
