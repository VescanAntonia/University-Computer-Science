package repository;

import model.exceptions.MyException;
import model.prgstate.PrgState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Repository implements IRepository{
    private List<PrgState> programStates;
    //private int currentState;

    private String logFilePath;


    public Repository(PrgState programState,String logFilePath){
        this.logFilePath=logFilePath;
        this.programStates=new ArrayList<>();
        this.addProgram(programState);
        //this.currentState=0;
        //this.addProgram(programState);
    }
    @Override
    public List<PrgState>getProgramList(){
        return this.programStates;
    }

    public void addProgram(PrgState program){
        this.programStates.add(program);
    }

//    @Override
//    public PrgState getCurrentState(){
//        return this.programStates.get(this.currentState);
//    }


    @Override
    public void setProgramStates(List<PrgState> programStates) {
        this.programStates = programStates;
    }
    @Override
    public void setProgramList(List<PrgState> programStates) {
        this.programStates = programStates;
    }
//    @Override
//    public void setCurrentState(int currentState) {
//        this.currentState = currentState;
//    }
    public void logPrgStateExec(PrgState programState) throws IOException,MyException{
        PrintWriter logFile = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true)));
        logFile.println(programStates.toString());
        logFile.close();
    }

}
