package view;//package view;
//import controller.Controller;
//import model.ADT.*;
//import model.exceptions.MyException;
//import model.expression.ArithExp;
//import model.expression.ValueExp;
//import model.expression.VarExp;
//import model.prgstate.PrgState;
//import model.statement.*;
//import model.type.BoolType;
//import model.type.IntType;
//import model.value.BoolValue;
//import model.value.IntValue;
//import model.value.Value;
//import repository.IRepository;
//import repository.Repository;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.util.*;
//import java.sql.SQLOutput;
//
//public class View {
//    public void start(){
//        boolean done=false;
//        while(!done){
//            try{
//                this.printMenu();
//                Scanner inputOption=new Scanner(System.in);
//                int userOption= inputOption.nextInt();
//                if(userOption==0)
//                    done=true;
//                else if(userOption==1)
//                    this.runProgramOne();
//                else if(userOption==2)
//                    this.runProgramTwo();
//                else if(userOption==3)
//                    this.runProgramThree();
//                else{
//                    System.out.println("  Invalid input!");
//                }
//            }catch(Exception exception){
//                System.out.println(exception.getMessage());
//            }
//        }
//    }
//    public void printMenu(){
//        System.out.println("MENU: ");
//        System.out.println("0.Exit. ");
//        System.out.println("1.Run the first program: int v; v=2;Print(v) ");
//        System.out.println("2.Run the second program: int a;int b; a=2+3*5;b=a+1;Print(b) ");
//        System.out.println("3.Run the third program: bool a; int v; a=true;(If a Then v=2 Else v=3);Print(v)");
//        System.out.println("Your option: ");
//    }
//    public void runProgramOne() throws IOException, MyException{
//        IStmt ex1= new CompStmt(new VarDeclStmt("v",new IntType()),
//                new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(2))), new PrintStmt(new VarExp("v"))));
//        this.runStatement(ex1);
//    }
//    public void runProgramTwo() throws IOException, MyException{
//        IStmt ex2 = new CompStmt(new VarDeclStmt("a",new IntType()),
//                new CompStmt(new VarDeclStmt("b",new IntType()),
//                        new CompStmt(new AssignStmt("a", new ArithExp('+',new ValueExp(new IntValue(2)),new
//                                ArithExp('*',new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
//                                new CompStmt(new AssignStmt("b",new ArithExp('+',new VarExp("a"), new ValueExp(new
//                                        IntValue(1)))), new PrintStmt(new VarExp("b"))))));
//        this.runStatement(ex2);
//    }
//    public void runProgramThree() throws IOException, MyException{
//        IStmt ex3 = new CompStmt(new VarDeclStmt("a",new BoolType()),
//                new CompStmt(new VarDeclStmt("v", new IntType()),
//                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
//                                new CompStmt(new IfStmt(new VarExp("a"),new AssignStmt("v",new ValueExp(
//                                        new IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))),
//                                        new PrintStmt(new VarExp("v"))))));
//        this.runStatement(ex3);
//    }
//
//    public void runStatement(IStmt stmt) throws IOException,MyException,InterruptedException{
//        MyIStack<IStmt> exeStack=new MyStack<>();
//        MyIDictionary<String, Value> symTbl= new MyDictionary<>();
//        MyIList<Value>output=new MyList<>();
//        MyIDictionary<String, BufferedReader>fileTable=new MyDictionary<>();
//        MyIHeap heap=new MyHeap();
//        PrgState state= new PrgState(exeStack,symTbl,output,stmt,fileTable,heap);
//        IRepository repository = new Repository(state,"log.txt");
//        Controller controller = new Controller(repository);
//        System.out.println("Do you want to show the steps?[Yes/No]");
//        Scanner readOption=new Scanner(System.in);
//        String option=readOption.next();
//        controller.setDisplayFlag(Objects.equals(option,"Yes"));
//        controller.allStep();
//        System.out.println("Result is "+state.getOut().toString().replace('[',' ').replace(']',' '));
//    }
//
//}
