package controller;

import model.ITree;
import repository.IRepository;

public class Controller {
    private IRepository repository;
    public Controller(IRepository repo){this.repository=repo;}

    public void add(ITree tree){
        this.repository.add(tree);
    }
    public void remove(Integer position){
        this.repository.remove(position);
    }
    public void printAll(Integer age){
        ITree[] trees= this.repository.getAll();
        for(ITree t:trees){
            if (t.solve(age))
                System.out.println(t.toString());
        }
    }
}
