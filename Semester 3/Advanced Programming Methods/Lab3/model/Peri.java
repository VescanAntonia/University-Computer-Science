package model;

public class Peri implements ITree {
    private Integer age;
    public Peri(Integer age){
        this.age=age;
    }
    public String toString(){
        return "Pear, years="+this.age;
    }
    public boolean solve(Integer age){
        if (this.age>=age) {
            return true;
        }
        return false;
    }
}
