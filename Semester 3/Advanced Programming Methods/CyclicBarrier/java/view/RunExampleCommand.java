package view;

import controller.Controller;
import model.exceptions.MyException;

import java.io.IOException;
import java.util.Objects;
import java.util.Scanner;

public class RunExampleCommand extends Command{
    private Controller ctrl;
    public RunExampleCommand(String key, String description, Controller ctrl){
        super(key,description);
        this.ctrl=ctrl;
    }

    @Override
    public void execute(){
        try {
            System.out.println("Do you want to display all steps?");
            Scanner readOption = new Scanner(System.in);
            String option = readOption.next();
            ctrl.setDisplayFlag(Objects.equals(option,"Yes"));
            ctrl.allStep();
        }catch(MyException|IOException|InterruptedException exception){
            System.out.println(exception.getMessage());
        }
    }
}
