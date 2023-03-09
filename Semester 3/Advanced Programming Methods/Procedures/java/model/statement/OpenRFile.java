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
import java.io.FileNotFoundException;
import java.io.FileReader;


public class OpenRFile implements IStmt {
    private IExpression expression;
    public OpenRFile(IExpression expression){
        this.expression=expression;
    }
    @Override
    public MyIDictionary<String, Type>typecheck(MyIDictionary<String,Type>typeEnv) throws MyException{
        if(expression.typecheck(typeEnv).equals(new StringType()))
            return typeEnv;
        else
            throw new MyException("OpenReadFile requires a string expression.");
    }

    @Override
    public PrgState execute(PrgState state)throws MyException {
        Value value = this.expression.eval(state.getSymTable().peek(),state.getHeap());
        if(value.getType().equals(new StringType())){
            StringValue fileName=(StringValue) value;
            MyIDictionary<String, BufferedReader>fileTable= state.getFileTable();
            if(!(fileTable.isDefined(fileName.getValue()))){
                BufferedReader br;
                try{
                    br=new BufferedReader(new FileReader(fileName.getValue()));
                }catch(FileNotFoundException e){
                    throw new MyException(fileName.getValue()+" could not be opened.");
                }
                fileTable.put(fileName.getValue(),br);
                state.setFileTable(fileTable);
            }
            else{
                throw new MyException(fileName.getValue()+" already in the fileTable, meaning its already opened.");

            }
        }
        else {
            throw new MyException(this.expression.toString()+" does not have its type StringType");
        }
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new OpenRFile(this.expression.deepCopy());
    }
    @Override
    public String toString(){
        return "OpenReadFile( "+this.expression.toString()+" )";
    }

}
