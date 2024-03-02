package com.example;

public class Max implements ICalculate{
    @Override
    public Integer calculate(Integer first, Integer second) {
        return (first > second) ? first : second;

    }
}
