package model;

public class Meri implements ITree{
    private Integer age;
    public Meri(Integer age){
        this.age=age;
    }
    public String toString(){
        return "Apple, years="+this.age;
    }
    public boolean solve(Integer age){
        if(this.age>=age){
            return true;
        }
        return false;
    }
}
