package com.example;

import com.google.common.math.Quantiles;

import java.util.Comparator;
import java.util.Objects;
import java.util.zip.GZIPInputStream;

public class Order implements Comparable<Order>{
    private int id;
    private int price;
    private int quantity;

    public Order(int id, int price, int quantity) {
        this.id = id;
        this.price = price;
        this.quantity = quantity;
    }

    public boolean equals(Object obj){
        if (this==obj) return true;
        if(obj==null|| getClass()!=obj.getClass()) return false;
        Order givenOrder=(Order)obj;
        return id==givenOrder.id&&price==givenOrder.price&&quantity==givenOrder.quantity;
    }

    public int hashCode(){
        return Objects.hash(id, price, quantity);
    }

    public int compareTo(Order order){
        return Integer.compare(this.id,order.id);
//        return Comparator.comparing(Order::getId)
//                .thenComparing(Order::getPrice)
//                .thenComparing(Order::getQuantity)
//                .compare(this, order);
//        int idComparison=Integer.compare(id, order.id);
//        if(idComparison!=0){
//            return idComparison;
//        }
//        int priceComparison=Integer.compare(price,order.price);
//        if(priceComparison!=0){
//            return priceComparison;
//        }
//        return Integer.compare(quantity, order.quantity);
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", price=" + price +
                ", quantity=" + quantity +
                '}';
    }

    public int getId() {
        return id;
    }

    public int getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }
}
