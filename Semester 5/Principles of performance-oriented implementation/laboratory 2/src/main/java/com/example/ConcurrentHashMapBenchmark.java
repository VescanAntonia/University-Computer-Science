package com.example;


import org.openjdk.jmh.annotations.*;

import java.util.concurrent.TimeUnit;

@BenchmarkMode(Mode.Throughput)
@OutputTimeUnit(TimeUnit.SECONDS)
@Warmup(iterations = 5, time = 1)
@Measurement(iterations = 10, time = 1, batchSize = 10)
@Fork(1)
public class ConcurrentHashMapBenchmark{
    @State(Scope.Benchmark)
    public static class BenchmarkState {
        MyConcurrentHashMap<Order> repository = new MyConcurrentHashMap<>();
        Order order = new Order(1, 50, 1);
        @Setup(Level.Iteration)
        public void setup() {
            repository.clear();
        }

    }

    @Benchmark
    public void add(BenchmarkState state) {
        state.repository.add(state.order);
    }

    @Benchmark
    public void remove(BenchmarkState state) {
        state.repository.remove(state.order);
    }

    @Benchmark
    public void contains(BenchmarkState state) {
        state.repository.contains(state.order);
    }
}
