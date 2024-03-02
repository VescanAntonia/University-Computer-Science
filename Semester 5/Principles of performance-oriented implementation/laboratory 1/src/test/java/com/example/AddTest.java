package com.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class AddTest {
    @Test
    void calculate() {
        ICalculate addOp= new Add();
        Assertions.assertEquals((int)addOp.calculate(4,5), 9);
    }
}