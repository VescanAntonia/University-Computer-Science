package model.statement;

import model.ADT.MyIDictionary;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.StringType;
import model.type.Type;
import model.value.StringValue;
import model.value.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class CloseRFile implements IStmt{
    private IExpression expression;
    public CloseRFile(IExpression exp){
        this.expression=exp;
    }

    @Override
    public MyIDictionary<String, Type>typecheck(MyIDictionary<String,Type>typeEnv)throws MyException{
        if(expression.typecheck(typeEnv).equals(new StringType()))
            return typeEnv;
        else
            throw new MyException("CloseReadFile requires a string expression.");
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        Value value = this.expression.eval(state.getSymTable(), state.getHeap());
        if(value.getType().equals(new StringType())){
            StringValue fileName=(StringValue) value;
            MyIDictionary<String, BufferedReader>fileTable=state.getFileTable();
            if(fileTable.isDefined(fileName.getValue())){
                BufferedReader br=fileTable.lookUp(fileName.getValue());
                try{
                    br.close();
                }catch(IOException e){
                    throw new MyException("There was an error closing "+value);
                }
                fileTable.remove(fileName.getValue());
                state.setFileTable(fileTable);
            }
            else{
                throw new MyException(value+" is not in the FileTable.");
            }
        }
        else {
            throw new MyException(this.expression.toString() + " does not evaluate to a String Value");
        }
        return null;
    }

    @Override
    public IStmt deepCopy(){
        return new CloseRFile(expression);
    }
    @Override
    public String toString(){
        return this.expression.toString();
    }
}
