package com.example;

import com.example.ICalculate;

public class Divide implements ICalculate {
    @Override
    public Integer calculate(Integer first, Integer second) {
        return first/second;
    }
}
