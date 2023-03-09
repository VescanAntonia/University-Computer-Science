package repository;

import model.exceptions.MyException;
import model.prgstate.PrgState;

import java.io.IOException;
import java.util.List;

public interface IRepository {
    void addProgram(PrgState program);
    void logPrgStateExec(PrgState programState) throws IOException, MyException;
    List<PrgState> getProgramList();
    void setProgramList(List<PrgState>programStates);

    void setProgramStates(List<PrgState> programStates);

}
