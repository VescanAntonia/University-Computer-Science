package model.ADT;

import model.exceptions.MyException;
import model.statement.IStmt;
import model.value.Value;
import javafx.util.Pair;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MyIProcTable {
    boolean isDefined(String key);
    void update(String key, Pair<List<String>, IStmt> value) throws MyException;
    void put(String key, Pair<List<String>,IStmt> value);
    void remove(String key) throws MyException;
    Collection<Pair<List<String>,IStmt>> values();
    Map<String, Pair<List<String>,IStmt>> getContent();
    Pair<List<String>,IStmt>lookUp(String key) throws MyException;
    MyIDictionary<String, Pair<List<String>,IStmt>> deepCopy() throws MyException;
}
