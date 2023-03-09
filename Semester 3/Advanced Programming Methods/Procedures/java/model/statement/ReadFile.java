package model.statement;

import model.ADT.MyIDictionary;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.IntType;
import model.type.StringType;
import model.type.Type;
import model.value.IntValue;
import model.value.StringValue;
import model.value.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class ReadFile implements IStmt{
    private IExpression expression;
    private String varName;
    public ReadFile(IExpression expression, String varName){
        this.expression=expression;
        this.varName=varName;
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type>typeEnv)throws MyException{
        if(expression.typecheck(typeEnv).equals(new StringType()))
            if(typeEnv.lookUp(varName).equals(new IntType()))
                return typeEnv;
            else
                throw new MyException("ReadFile requires an int as its variable parameter.");
        else
            throw new MyException("ReadFile requires a string as es expression parameter.");
    }
    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String,Value> symTable=state.getSymTable().peek();
        MyIDictionary<String, BufferedReader>fileTable=state.getFileTable();

        if(symTable.isDefined(varName)) {
            Value value = symTable.lookUp(this.varName);
            if (value.getType().equals(new IntType())) {
                value = expression.eval(symTable,state.getHeap());
                if (value.getType().equals(new StringType())) {
                    StringValue castValue = (StringValue) value;
                    if (fileTable.isDefined(castValue.getValue())) {
                        BufferedReader br=fileTable.lookUp(castValue.getValue());
                        try{
                            String line=br.readLine();
                            if(line==null)
                                line="0";
                            symTable.put(varName,new IntValue(Integer.parseInt(line)));
                        }catch(IOException e){
                            throw new MyException("Could not read from file "+castValue);
                        }
                    } else {
                        throw new MyException("The fileTable does not contain " + castValue);
                    }
                } else {
                    throw new MyException(this.expression.toString() + " is not of StringType.");
                }
            } else {
                throw new MyException(this.expression.toString() + " is not of IntType.");
            }
        }
        else{
            throw new MyException(this.varName+" is not defined in the symTable");
        }
        return null;
    }

    @Override
    public IStmt deepCopy(){
        return new ReadFile(expression,varName);
    }
    @Override
    public String toString(){
        return this.expression.toString()+" "+this.varName;
    }
}
