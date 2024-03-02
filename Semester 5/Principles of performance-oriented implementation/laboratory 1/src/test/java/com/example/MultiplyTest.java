package com.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class MultiplyTest {
    @Test
    void calculate() {
        ICalculate multiplyOp=new Multiply();
        Assertions.assertEquals((int)multiplyOp.calculate(5,4), 20);
    }
}