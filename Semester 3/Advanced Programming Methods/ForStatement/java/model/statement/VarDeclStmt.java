package model.statement;
import model.ADT.MyIDictionary;
import model.exceptions.MyException;
import model.prgstate.PrgState;
import model.type.Type;
import model.value.Value;

public class VarDeclStmt implements IStmt {
    private String name;
    private Type type;
    public VarDeclStmt(String name, Type type){
        this.name=name;
        this.type=type;
    }
    public MyIDictionary<String,Type> typecheck(MyIDictionary<String,Type> typeEnv) throws MyException{
        typeEnv.put(name,type);
        return typeEnv;
    }
    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable=state.getSymTable();
        if(symTable.isDefined(name)){
            throw new MyException("Variable"+this.name+" already exists in the symTable. ");
        }
        symTable.put(name,type.defaultValue());
        state.setSymTable(symTable);
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new VarDeclStmt(name, type);
    }
    @Override
    public String toString(){
        return this.type.toString()+" "+name;
    }
}
