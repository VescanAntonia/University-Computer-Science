package view;

import model.ITree;
import model.Meri;
import model.Peri;
import model.Ciresi;
import repository.IRepository;
import repository.Repository;
import controller.*;

public class Main {
    public static void main(String[] args){
        ITree t1 = new Meri(5);
        ITree t2 = new Peri(1);
        ITree t3 = new Ciresi(4);
        ITree t4 = new Ciresi(2);
        ITree t5=  new Meri(6);
        ITree t6=new Peri(2);


        IRepository repo = new Repository(5);
        Controller controller = new Controller(repo);

        controller.add(t1);
        controller.add(t2);
        controller.add(t3);
        controller.add(t4);
        controller.add(t5);
        controller.add(t6);

        System.out.println("The trees that are older than 3 years: ");
        controller.printAll(3);
        System.out.println("After we delete a tree: ");
        controller.remove(2);
        controller.printAll(3);
    }
}
