package com.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class DivideTest {
    @Test
    void calculate() {
        ICalculate divideOp=new Divide();
        Assertions.assertEquals((int)divideOp.calculate(8,4), 2);
    }
}