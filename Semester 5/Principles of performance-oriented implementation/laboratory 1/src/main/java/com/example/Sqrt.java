package com.example;

public class Sqrt implements ICalculate{
    @Override
    public Integer calculate(Integer first, Integer second) {
        if(second==0) {
            return (int) Math.sqrt(first);
        }
        else{
            return 0;
        }
    }
}
