package com.example;

import org.apache.logging.log4j.core.util.JsonUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) throws IOException {
        org.openjdk.jmh.Main.main(args);
//        List<BigDecimal> bigDecimals = Arrays.asList(
//                new BigDecimal("10.5"),
//                new BigDecimal("20.7"),
//                new BigDecimal("15.2"),
//                new BigDecimal("8.9"),
//                new BigDecimal("25.1")
//        );
//        List<Double> doublesList = Arrays.asList(3.14, 2.71, 1.618, 0.707, 2.0);
//        double[] primitiveList={2.60, 1.618,8.67,2,57};
//
//        BigDecimalsOperations<BigDecimal> bigDecimalOperations = new BigDecimalsOperations<>(bigDecimals);
//
//    // Compute the sum of elements
//        System.out.println("Sum: " + bigDecimalOperations.sum());
//
//    // Compute the average of elements
//        System.out.println("Average: " + bigDecimalOperations.average());
//
//    // Print the top 10% biggest numbers
//        System.out.println("Top 10%: " + bigDecimalOperations.topPercent(0.1));
//
//    // Unit tests
//        assert bigDecimalOperations.sum().equals(new BigDecimal("80.4"));
//        assert bigDecimalOperations.average().equals(new BigDecimal("16.08"));
//        assert bigDecimalOperations.topPercent(0.1).equals(Arrays.asList(new BigDecimal("25.1")));
//
//        System.out.println("All tests passed!");
    }
}