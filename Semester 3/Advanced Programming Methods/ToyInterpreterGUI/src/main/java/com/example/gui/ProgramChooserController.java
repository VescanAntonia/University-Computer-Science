package com.example.gui;
import controller.Controller;
import model.exceptions.MyException;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import model.expression.*;
import model.prgstate.PrgState;
import model.statement.*;
import model.type.BoolType;
import model.type.IntType;
import model.type.RefType;
import model.type.StringType;
import model.ADT.MyDictionary;
import model.ADT.MyHeap;
import model.ADT.MyList;
import model.ADT.MyStack;
import model.value.BoolValue;
import model.value.IntValue;
import model.value.StringValue;
import repository.IRepository;
import repository.Repository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ProgramChooserController {
    private ProgramExecutorController programExecutorController;

    public void setProgramExecutorController(ProgramExecutorController programExecutorController) {
        this.programExecutorController = programExecutorController;
    }
    @FXML
    private ListView<IStmt> programsListView;

    @FXML
    private Button displayButton;

    @FXML
    public void initialize() {
        programsListView.setItems(getAllStatements());
        programsListView.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
    }

    @FXML
    private void displayProgram(ActionEvent actionEvent) throws  MyException{
        IStmt selectedStatement = programsListView.getSelectionModel().getSelectedItem();
        if (selectedStatement == null) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("Error encountered!");
            alert.setContentText("No statement selected!");
            alert.showAndWait();
        } else {
            int id = programsListView.getSelectionModel().getSelectedIndex();
            try {
                selectedStatement.typecheck(new MyDictionary<>());
                PrgState programState = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), selectedStatement,new MyDictionary<>(), new MyHeap());
                IRepository repository = new Repository(programState, "log" + (id + 1) + ".txt");
                Controller controller = new Controller(repository);
                programExecutorController.setController(controller);
            } catch (MyException exception) {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Error encountered!");
                alert.setContentText(exception.getMessage());
                alert.showAndWait();
            }
        }
    }

    @FXML
    private ObservableList<IStmt> getAllStatements() {
        List<IStmt> allStatements = new ArrayList<>();

        IStmt ex1=new CompStmt(new VarDeclStmt("v",new IntType()),
                new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(2))), new PrintStmt(new VarExp("v"))));

        allStatements.add(ex1);

        IStmt ex2 = new CompStmt(new VarDeclStmt("a",new StringType()),    ///IntType() TODO
                new CompStmt(new VarDeclStmt("b",new IntType()),
                        new CompStmt(new AssignStmt("a", new ArithExp('+',new ValueExp(new IntValue(2)),new
                                ArithExp('*',new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                                new CompStmt(new AssignStmt("b",new ArithExp('+',new VarExp("a"), new ValueExp(new
                                        IntValue(1)))), new PrintStmt(new VarExp("b"))))));
        allStatements.add(ex2);

        IStmt ex3 = new CompStmt(new VarDeclStmt("a",new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VarExp("a"),new AssignStmt("v",new ValueExp(
                                        new IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))),
                                        new PrintStmt(new VarExp("v"))))));
        allStatements.add(ex3);

        IStmt ex4 = new CompStmt(new VarDeclStmt("varf", new StringType()),
                new CompStmt(new AssignStmt("varf", new ValueExp(new StringValue("test.in"))),
                        new CompStmt(new OpenRFile(new VarExp("varf")),
                                new CompStmt(new VarDeclStmt("varc", new IntType()),
                                        new CompStmt(new ReadFile(new VarExp("varf"), "varc"),
                                                new CompStmt(new PrintStmt(new VarExp("varc")),
                                                        new CompStmt(new ReadFile(new VarExp("varf"), "varc"),
                                                                new CompStmt(new PrintStmt(new VarExp("varc")), new CloseRFile(new VarExp("varf"))))))))));
        allStatements.add(ex4);

        IStmt ex5 = new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new VarDeclStmt("b", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new IntValue(5))),
                                new CompStmt(new AssignStmt("b", new ValueExp(new IntValue(7))),
                                        new IfStmt(new RelationalExpression(">", new VarExp("a"),
                                                new VarExp("b")),new PrintStmt(new VarExp("a")),
                                                new PrintStmt(new VarExp("b")))))));

        allStatements.add(ex5);

        IStmt ex6 = new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(4))),
                new CompStmt(new WhileStmt(new RelationalExpression(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                        new CompStmt(new PrintStmt(new VarExp("v")), new AssignStmt("v",new ArithExp('-', new VarExp("v"), new ValueExp(new IntValue(1)))))),
                        new PrintStmt(new VarExp("v")))));
        allStatements.add(ex6);

        IStmt ex7 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new VarExp("a")))))));
        allStatements.add(ex7);

        IStmt ex8 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new PrintStmt(new RHeap(new VarExp("v"))),
                                                new PrintStmt(new ArithExp('+',new RHeap(new RHeap(new VarExp("a"))), new ValueExp(new IntValue(5)))))))));
        allStatements.add(ex8);

        IStmt ex9 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt( new PrintStmt(new RHeap(new VarExp("v"))),
                                new CompStmt(new WriteHeap("v", new ValueExp(new IntValue(30))),
                                        new PrintStmt(new ArithExp('+', new RHeap(new VarExp("v")), new ValueExp(new IntValue(5))))))));
        allStatements.add(ex9);

        IStmt ex10 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new NewStmt("v", new ValueExp(new IntValue(30))),
                                                new PrintStmt(new RHeap(new RHeap(new VarExp("a")))))))));
        allStatements.add(ex10);

        IStmt ex11 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new VarDeclStmt("a", new RefType(new IntType())),
                        new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(10))),
                                new CompStmt(new NewStmt("a", new ValueExp(new IntValue(22))),
                                        new CompStmt(new ForkStmt(new CompStmt(new WriteHeap("a", new ValueExp(new IntValue(30))),
                                                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(32))),
                                                        new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new RHeap(new VarExp("a"))))))),
                                                new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new RHeap(new VarExp("a")))))))));

        allStatements.add(ex11);


//        IStmt ex12 = new CompStmt(new VarDeclStmt("a", new RefType(new IntType())),
//                new CompStmt(new VarDeclStmt("b", new RefType(new IntType())),
//                        new CompStmt(new VarDeclStmt("v",new IntType()),
//                        new CompStmt(new AssignStmt("a", new ValueExp(new IntValue(0))),
//                                new CompStmt(new AssignStmt("b",new ValueExp(new IntValue(0))),
//                                    new CompStmt(new WriteHeap("a", new ValueExp(1)),)
//
//                                new CompStmt(new CondAssignStmt("b",
//                                        new VarExp("a"),
//                                        new ValueExp(new IntValue(100)),
//                                        new ValueExp(new IntValue(200))),
//                                        new CompStmt(new PrintStmt(new VarExp("c")),
//                                                new CompStmt(new CondAssignStmt("c",
//                                                        new ValueExp(new BoolValue(false)),
//                                                        new ValueExp(new IntValue(100)),
//                                                        new ValueExp(new IntValue(200))),
//                                                        new PrintStmt(new VarExp("c"))))))))));
//        allStatements.add(ex12);

        IStmt ex12 = new CompStmt(new VarDeclStmt("a", new RefType(new IntType())),
                new CompStmt(new VarDeclStmt("b", new RefType(new IntType())),
                        new CompStmt(new VarDeclStmt("v",new IntType()),
                                new CompStmt(new NewStmt("a",new ValueExp(new IntValue(0))),
                                        new CompStmt(new NewStmt("b",new ValueExp(new IntValue(0))),
                                                new CompStmt(new WriteHeap("a", new ValueExp(new IntValue(1))),
                                                        new CompStmt(new WriteHeap("b",new ValueExp(new IntValue(2))),
                                                                new CompStmt(new CondAssignStmt
                                                                        ("v",new RelationalExpression("<", new RHeap(new VarExp("a")),new RHeap(new VarExp("b"))),new ValueExp(new IntValue(100)),new ValueExp(new IntValue(200))),
                                                                        new CompStmt(new PrintStmt(new VarExp("v")),
                                                                                new CompStmt(new CondAssignStmt
                                                                                        ("v", new RelationalExpression(">",new ArithExp('-' ,new RHeap(new VarExp("b")),new ValueExp(new IntValue(2))),new RHeap(new VarExp("a"))),new ValueExp(new IntValue(100)),new ValueExp(new IntValue(200))),
                                                                                        new PrintStmt(new VarExp("v"))))))))))));
        allStatements.add(ex12);
//        IStmt ex12 = new CompStmt(new VarDeclStmt("a", new BoolType()),
//                new CompStmt(new VarDeclStmt("b", new IntType()),
//                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
//                                new CompStmt(new CondAssignStmt("b",
//                                        new VarExp("a"),
//                                        new ValueExp(new IntValue(100)),
//                                        new ValueExp(new IntValue(200))),
//                                        new CompStmt(new PrintStmt(new VarExp("c")),
//                                                new CompStmt(new CondAssignStmt("c",
//                                                        new ValueExp(new BoolValue(false)),
//                                                        new ValueExp(new IntValue(100)),
//                                                        new ValueExp(new IntValue(200))),
//                                                        new PrintStmt(new VarExp("c"))))))));
//        allStatements.add(ex12);

        return FXCollections.observableArrayList(allStatements);
    }
}
