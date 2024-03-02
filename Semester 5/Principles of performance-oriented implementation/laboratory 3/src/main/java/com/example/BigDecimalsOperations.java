package com.example;

import java.util.List;
import java.util.stream.Collectors;

public class BigDecimalsOperations<T extends Number> {
    private final List<T> numbers;

    public BigDecimalsOperations(List<T> numbers) {
        this.numbers = numbers;
    }

    public T sum() {
        return numbers.stream()
                .reduce(zero(), this::add);
    }
    public T average() {
        return divide(sum(), cast(numbers.size()));
    }

    public List<T> topPercent(double percent) {
        int size = (int) (numbers.size() * percent);
        return numbers.stream()
                .sorted((a, b) -> compare(b, a))
                .limit(size)
                .collect(Collectors.toList());
    }

    private T zero() {
        //return the 0 value for the given type
        return cast(0);
    }

    private T add(T a, T b) {
        //adds two nrs
        return cast(doubleValue(a) + doubleValue(b));
    }

    private T divide(T a, T b) {
        //divide 2 nrs
        return cast(doubleValue(a) / doubleValue(b));
    }

    private int compare(T a, T b) {
        //compares two nrs
        return Double.compare(doubleValue(a), doubleValue(b));
    }

    private double doubleValue(T number) {
        //converts to double
        return number.doubleValue();
    }

    @SuppressWarnings("unchecked")
    private T cast(Number number) {
        //casts a nr to generic T
        return (T) number;
    }

    // handles primitive doubles
    public static BigDecimalsOperations<Double> forPrimitiveDoubles(List<Double> numbers) {
        //create a BigDecimalsOperations instance specifically for lists of primitive doubles
        return new BigDecimalsOperations<>(numbers);
    }
    public void clear(){
        this.numbers.clear();
    }
}
