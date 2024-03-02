package com.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;


class MinTest {

    @Test
    void calculate() {
        ICalculate minOp=new Min();
        Assertions.assertEquals((int)minOp.calculate(5,2), 2);
    }
}