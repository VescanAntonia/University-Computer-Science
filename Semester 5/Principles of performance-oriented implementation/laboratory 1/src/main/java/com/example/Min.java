package com.example;

public class Min implements ICalculate{

    @Override
    public Integer calculate(Integer first, Integer second) {
        return (first > second) ? second : first;
    }
}
