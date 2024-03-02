package com.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;


class MaxTest {

    @Test
    void calculate() {
        ICalculate maxOp=new Max();
        Assertions.assertEquals((int)maxOp.calculate(2,6), 6);
    }
}