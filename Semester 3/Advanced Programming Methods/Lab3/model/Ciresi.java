package model;

public class Ciresi implements ITree{
    private Integer age;
    public Ciresi(Integer age){
        this.age=age;
    }
    public String toString(){
        return "Cherry, years="+this.age;
    }
    public boolean solve(Integer age){
        if(this.age>=age){
            return true;
        }
        return false;
    }
}
