package com.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class SubstractTest {
    @Test
    void calculate() {
        ICalculate substractOp=new Substract();
        Assertions.assertEquals((int)substractOp.calculate(5,2), 3);
    }
}