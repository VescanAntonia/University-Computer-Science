package com.example;

public class Multiply implements ICalculate{
    @Override
    public Integer calculate(Integer first, Integer second) {
        return first*second;
    }
}
