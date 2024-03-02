package com.example;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

class BigDecimalsOperationsTest {
    List<BigDecimal> bigDecimals = Arrays.asList(
            new BigDecimal("10.5"),
            new BigDecimal("20.7"),
            new BigDecimal("15.2"),
            new BigDecimal("8.9"),
            new BigDecimal("25.1")
    );
    List<Double> doublesList = Arrays.asList(3.14, 2.71, 1.618, 0.707, 2.0);
    double[] primitiveList={2.60, 1.618,8.67,2,57};
    List<Double> doublePrimitiveList = Arrays.stream(primitiveList).boxed().collect(Collectors.toList());


    BigDecimalsOperations<BigDecimal> bigDecimalOperations = new BigDecimalsOperations<>(bigDecimals);

    BigDecimalsOperations<Double> doubleOperations = new BigDecimalsOperations<>(doublesList);


//    BigDecimalsOperations<?> primitiveOperations = new BigDecimalsOperations<>(Arrays.asList(2.60, 1.618, 8.67, 2.0, 57.0));

    BigDecimalsOperations<?> primitiveOperations = BigDecimalsOperations.forPrimitiveDoubles(doublePrimitiveList);

    @Test
    void sum() {
        assertEquals(bigDecimalOperations.sum(),80.4);
        assertEquals(doubleOperations.sum(),10.175);
        assertEquals(primitiveOperations.sum(),71.888);
    }

    @Test
    void average() {
        assertEquals(bigDecimalOperations.average(),16.080000000000002);
        assertEquals(doubleOperations.average(),2.035);
        assertEquals(primitiveOperations.average(),14.377600000000001);
    }

    @Test
    void topPercent() {
//        List<BigDecimal> expectedBigDecimalResult = Arrays.asList(new BigDecimal("25.1"));
//        List<Double> expectedDoubleResult = Arrays.asList(3.14);
//
//        assertEquals(expectedBigDecimalResult.get(0), bigDecimalOperations.topPercent(0.1).get(0));
//        assertEquals(expectedDoubleResult.get(0), doubleOperations.topPercent(0.1).get(0));

        assertEquals(bigDecimalOperations.topPercent(0.25),Arrays.asList(new BigDecimal("25.1")));
        assertEquals(doubleOperations.topPercent(0.25),Arrays.asList(3.14));
        assertEquals(primitiveOperations.topPercent(0.25),Arrays.asList(57.0));

//        System.out.println(bigDecimalOperations.topPercent(0.1));
//        assertEquals(doubleOperations.topPercent(0.1),3.14);
//        assertEquals(primitiveOperations.topPercent(0.1),57.0);
    }
}