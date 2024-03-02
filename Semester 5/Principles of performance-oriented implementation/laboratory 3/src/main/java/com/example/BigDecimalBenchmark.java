package com.example;

import org.openjdk.jmh.annotations.*;
import org.openjdk.jmh.infra.Blackhole;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@BenchmarkMode(Mode.Throughput)
@OutputTimeUnit(TimeUnit.SECONDS)
@Warmup(iterations = 5, time = 1)
@Measurement(iterations = 10, time = 1, batchSize = 10)
@Fork(1)
public class BigDecimalBenchmark {
    @State(Scope.Benchmark)
    public static class BenchmarkState {
//        List<BigDecimal> bigDecimals = Arrays.asList(
//                new BigDecimal("10.5"),
//                new BigDecimal("20.7"),
//                new BigDecimal("15.2"),
//                new BigDecimal("8.9"),
//                new BigDecimal("25.1")
//        );
        List<BigDecimal> bigDecimals = generateRandomBigDecimals(100);
        BigDecimalsOperations<BigDecimal> repository = new BigDecimalsOperations<>(bigDecimals);


        private List<BigDecimal> generateRandomBigDecimals(int size) {
            Random random = new Random();
            List<BigDecimal> randomDoubles=new ArrayList<>();
            //List<Double> randomDoubles = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                int scale=10; //precision of 10 decimals
                //for specifying the precision and rounding behavior for the BigDecimal operations
                MathContext mathContext=new MathContext(scale);
                randomDoubles.add(new BigDecimal(random.nextDouble(),mathContext));
            }
            return randomDoubles;
        }

        @Setup(Level.Iteration)
        public void setup() {
            repository.clear();
        }

    }

    //using blackholes so that the compiler doesn't optimize the method calls by itself
    @Benchmark
    public void sum(BenchmarkState state, Blackhole blackhole) {
        blackhole.consume(state.repository.sum());
    }

    @Benchmark
    public void average(BenchmarkState state, Blackhole blackhole) {
        blackhole.consume(state.repository.average());
    }

    @Benchmark
    public void topPercent(BenchmarkState state, Blackhole blackhole) {
        blackhole.consume(state.repository.topPercent(0.1));
    }
}
