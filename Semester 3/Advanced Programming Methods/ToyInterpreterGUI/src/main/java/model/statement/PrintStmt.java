package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIList;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.Type;
import model.value.Value;

public class PrintStmt implements IStmt {
    IExpression exp;
    public PrintStmt(IExpression exp){
        this.exp=exp;
    }
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type> typeEnv) throws MyException{
        exp.typecheck(typeEnv);
        return typeEnv;
    }
    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIList<Value> out = state.getOut();
        out.add(exp.eval(state.getSymTable(),state.getHeap()));
        state.setOut(out);
        return null;
    }
    @Override
    public IStmt deepCopy(){
        return new PrintStmt(exp.deepCopy());
    }
    @Override
    public String toString(){
        return "print("+exp.toString()+")";}
}
