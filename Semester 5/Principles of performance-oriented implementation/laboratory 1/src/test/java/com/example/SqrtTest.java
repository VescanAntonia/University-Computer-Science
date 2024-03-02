package com.example;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;


class SqrtTest {

    @Test
    void calculate() {
        ICalculate sqrtPos=new Sqrt();
        Assertions.assertEquals((int)sqrtPos.calculate(16,0), 4);
        Assertions.assertEquals((int)sqrtPos.calculate(16,16),0);
    }
}