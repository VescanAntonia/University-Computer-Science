package view;

import controller.Controller;
import model.ADT.*;
import model.exceptions.MyException;
import model.expression.*;
import model.prgstate.PrgState;
import model.statement.*;
import model.type.BoolType;
import model.type.IntType;
import model.type.RefType;
import model.type.StringType;
import model.value.BoolValue;
import model.value.IntValue;
import model.value.StringValue;
import repository.IRepository;
import repository.Repository;

public class Interpreter {
    public static void main(String[] args){
        TextMenu menu=new TextMenu();
        menu.addCommand(new ExitCommand("0","exit"));


        IStmt ex1=new CompStmt(new VarDeclStmt("v",new IntType()),
                new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(2))), new PrintStmt(new VarExp("a"))));
      // last VarExp is v not a TODO
        try {
            ex1.typecheck(new MyDictionary<>());
            PrgState prg1 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), ex1, new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo1 = new Repository(prg1, "log1.txt");
            Controller ctrl1 = new Controller((repo1));
            menu.addCommand(new RunExampleCommand("1",ex1.toString(),ctrl1));
        }catch (MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }


        IStmt ex2 = new CompStmt(new VarDeclStmt("a",new StringType()),    ///IntType() TODO
                new CompStmt(new VarDeclStmt("b",new IntType()),
                        new CompStmt(new AssignStmt("a", new ArithExp('+',new ValueExp(new IntValue(2)),new
                                ArithExp('*',new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                                new CompStmt(new AssignStmt("b",new ArithExp('+',new VarExp("a"), new ValueExp(new
                                        IntValue(1)))), new PrintStmt(new VarExp("b"))))));
        try{
            ex2.typecheck(new MyDictionary<>());
            PrgState prg2=new PrgState(new MyStack<>(),new MyDictionary<>(), new MyList<>(),ex2,new MyDictionary<>(),new MyHeap(),new MyToySemaphoreTable());
            IRepository repo2= new Repository(prg2,"log2.txt");
            Controller ctrl2=new Controller((repo2));
            menu.addCommand(new RunExampleCommand("2",ex2.toString(),ctrl2));
        }catch (MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }




        IStmt ex3 = new CompStmt(new VarDeclStmt("a",new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VarExp("a"),new AssignStmt("v",new ValueExp(
                                        new IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))),
                                        new PrintStmt(new VarExp("v"))))));
        try{
            ex3.typecheck(new MyDictionary<>());
            PrgState prg3=new PrgState(new MyStack<>(),new MyDictionary<>(), new MyList<>(),ex3,new MyDictionary<>(),new MyHeap(),new MyToySemaphoreTable());
            IRepository repo3= new Repository(prg3,"log3.txt");
            Controller ctrl3=new Controller((repo3));
            menu.addCommand(new RunExampleCommand("3",ex3.toString(),ctrl3));
        }catch (MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }





        IStmt ex4 = new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new VarDeclStmt("b", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new IntValue(5))),
                                new CompStmt(new AssignStmt("b", new ValueExp(new IntValue(7))),
                                        new IfStmt(new RelationalExpression(">", new VarExp("a"),
                                                new VarExp("b")),new PrintStmt(new VarExp("a")),
                                                new PrintStmt(new VarExp("b")))))));

        try{
            ex4.typecheck(new MyDictionary<>());
            PrgState prg4 = new PrgState(new MyStack<>(),new MyDictionary<>(), new MyList<>(),ex4,new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo4 = new Repository(prg4, "log4.txt");
            Controller ctrl4 = new Controller(repo4);
            menu.addCommand(new RunExampleCommand("4",ex4.toString(),ctrl4));
        }catch (MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }



        IStmt ex5 = new CompStmt(new VarDeclStmt("varf", new StringType()),
                new CompStmt(new AssignStmt("varf", new ValueExp(new StringValue("test.in"))),
                        new CompStmt(new OpenRFile(new VarExp("varf")),
                                new CompStmt(new VarDeclStmt("varc", new IntType()),
                                        new CompStmt(new ReadFile(new VarExp("varf"), "varc"),
                                                new CompStmt(new PrintStmt(new VarExp("varc")),
                                                        new CompStmt(new ReadFile(new VarExp("varf"), "varc"),
                                                                new CompStmt(new PrintStmt(new VarExp("varc")), new CloseRFile(new VarExp("varf"))))))))));
        try{
            ex5.typecheck(new MyDictionary<>());
            PrgState prg5 = new PrgState(new MyStack<>(),new MyDictionary<>(), new MyList<>(),ex5,new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo5 = new Repository(prg5, "log5.txt");
            Controller ctrl5 = new Controller(repo5);
            menu.addCommand(new RunExampleCommand("5",ex5.toString(),ctrl5));
        }catch(MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }




        //For heap allocation example
        IStmt ex6 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new VarExp("a")))))));
        try{
            ex6.typecheck(new MyDictionary<>());
            PrgState prg6 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(),ex6, new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo6;
            repo6 = new Repository(prg6, "log6.txt");
            Controller ctrl6 = new Controller(repo6);
            menu.addCommand(new RunExampleCommand("6", ex6.toString(), ctrl6));
        }catch (MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }





        //For heap read example
        IStmt ex7 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new PrintStmt(new RHeap(new VarExp("v"))),
                                                new PrintStmt(new ArithExp('+',new RHeap(new RHeap(new VarExp("a"))), new ValueExp(new IntValue(5)))))))));
        try{
            ex7.typecheck(new MyDictionary<>());
            PrgState prg7 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), ex7,new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo7;
            repo7 = new Repository(prg7, "log7.txt");
            Controller ctrl7 = new Controller(repo7);
            menu.addCommand(new RunExampleCommand("7", ex7.toString(), ctrl7));
        }catch(MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }





        //Write heap example
        IStmt ex8 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt( new PrintStmt(new RHeap(new VarExp("v"))),
                                new CompStmt(new WriteHeap("v", new ValueExp(new IntValue(30))),
                                        new PrintStmt(new ArithExp('+', new RHeap(new VarExp("v")), new ValueExp(new IntValue(5))))))));
        try{
            ex8.typecheck(new MyDictionary<>());
            PrgState prg8 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(),ex8, new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo8;
            repo8 = new Repository(prg8, "log8.txt");
            Controller ctrl8 = new Controller(repo8);
            menu.addCommand(new RunExampleCommand("8", ex8.toString(), ctrl8));
        }catch(MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }



        //  This will throw an error at the unsafe garbage collector
        IStmt ex9 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new NewStmt("v", new ValueExp(new IntValue(30))),
                                                new PrintStmt(new RHeap(new RHeap(new VarExp("a")))))))));
        try{
            ex9.typecheck(new MyDictionary<>());
            PrgState prg9 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(),ex9, new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo9;
            repo9 = new Repository(prg9, "log9.txt");
            Controller ctrl9 = new Controller(repo9);
            menu.addCommand(new RunExampleCommand("9", ex9.toString(), ctrl9));
        }catch (MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }




        //  For the while statement
        IStmt ex10 = new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(4))),
                new CompStmt(new WhileStmt(new RelationalExpression(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                new CompStmt(new PrintStmt(new VarExp("v")), new AssignStmt("v",new ArithExp('-', new VarExp("v"), new ValueExp(new IntValue(1)))))),
                new PrintStmt(new VarExp("v")))));
        try{
            ex10.typecheck(new MyDictionary<>());
            PrgState prg10 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(),ex10, new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo10;
            repo10 = new Repository(prg10, "log10.txt");
            Controller ctrl10 = new Controller(repo10);
            menu.addCommand(new RunExampleCommand("10", ex10.toString(), ctrl10));
        }catch(MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }




        IStmt ex11 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new VarDeclStmt("a", new RefType(new IntType())),
                        new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(10))),
                                new CompStmt(new NewStmt("a", new ValueExp(new IntValue(22))),
                                        new CompStmt(new ForkStmt(new CompStmt(new WriteHeap("a", new ValueExp(new IntValue(30))),
                                                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(32))),
                                                        new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new RHeap(new VarExp("a"))))))),
                                                new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new RHeap(new VarExp("a")))))))));
        //ex12.typeCheck(new MyDictionary<>());
        try{
            ex11.typecheck(new MyDictionary<>());
            PrgState prg11 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(),ex11, new MyDictionary<>(), new MyHeap(),new MyToySemaphoreTable());
            IRepository repo11;
            repo11 = new Repository(prg11, "log11.txt");
            Controller controller11 = new Controller(repo11);
            menu.addCommand(new RunExampleCommand("11", ex11.toString(), controller11));
        }catch(MyException e){
            System.out.println("\u001B[31m" + e.getMessage() + "\u001B[0m");
        }


        //menu.addCommand(new ExitCommand("0", "exit"));
        //menu.addCommand(new RunExampleCommand("1",ex1.toString(),ctrl1));
        //menu.addCommand(new RunExampleCommand("2",ex2.toString(),ctrl2));
        //menu.addCommand(new RunExampleCommand("3",ex3.toString(),ctrl3));
        //menu.addCommand(new RunExampleCommand("4",ex4.toString(),ctrl4));
        //menu.addCommand(new RunExampleCommand("5",ex5.toString(),ctrl5));
        //menu.addCommand(new RunExampleCommand("6", ex6.toString(), ctrl6));
        //menu.addCommand(new RunExampleCommand("7", ex7.toString(), ctrl7));
        //menu.addCommand(new RunExampleCommand("8", ex8.toString(), ctrl8));
        //menu.addCommand(new RunExampleCommand("9", ex9.toString(), ctrl9));
        //menu.addCommand(new RunExampleCommand("10", ex10.toString(), ctrl10));
        //menu.addCommand(new RunExampleCommand("11", ex11.toString(), controller11));
        menu.show();
    }
}
