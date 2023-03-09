package repository;


import model.ITree;

public interface IRepository {
    public void add(ITree tree);
    public void remove(Integer position);
    public ITree[] getAll();
}
