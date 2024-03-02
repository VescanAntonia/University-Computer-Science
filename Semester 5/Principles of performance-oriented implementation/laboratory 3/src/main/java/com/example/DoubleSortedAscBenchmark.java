package com.example;


import org.openjdk.jmh.annotations.*;
import org.openjdk.jmh.infra.Blackhole;

import java.util.*;
import java.util.concurrent.TimeUnit;

@BenchmarkMode(Mode.Throughput)
@OutputTimeUnit(TimeUnit.SECONDS)
@Warmup(iterations = 5, time = 1)
@Measurement(iterations = 10, time = 1, batchSize = 10)
@Fork(1)
public class DoubleSortedAscBenchmark {
    @State(Scope.Benchmark)
    public static class BenchmarkState {
        List<Double> doublesList = generateRandomDoubles(100);
        BigDecimalsOperations<Double> repository = new BigDecimalsOperations<>(doublesList);
        private List<Double> generateRandomDoubles(int size) {
            Random random = new Random();
            List<Double> randomDoubles = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                randomDoubles.add(random.nextDouble());
            }
            Collections.sort(randomDoubles);
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

