package model.statement;

import model.ADT.MyIDictionary;
import model.ADT.MyIStack;
import model.exceptions.MyException;
import model.expression.IExpression;
import model.prgstate.PrgState;
import model.type.BoolType;
import model.type.Type;
import model.value.BoolValue;
import model.value.Value;

public class IfStmt implements IStmt{
    IExpression exp;
    IStmt thenS;
    IStmt elseS;
    public IfStmt(IExpression expression,IStmt then, IStmt els){
        this.exp=expression;
        this.thenS=then;
        this.elseS=els;
    }
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String,Type> typeEnv) throws MyException{
        Type typexp=exp.typecheck(typeEnv);
        if (typexp.equals(new BoolType())) {
            thenS.typecheck(typeEnv.deepCopy());
            elseS.typecheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else
            throw new MyException("The condition of IF has not the type bool");
    }
    @Override
    public PrgState execute(PrgState state) throws MyException{
        Value result = this.exp.eval(state.getSymTable().peek(), state.getHeap());
        if(result instanceof BoolValue boolResult){
            IStmt statement;
            if(boolResult.getValue()){
                statement=thenS;
            }
            else {
                statement=elseS;
            }
            MyIStack<IStmt> stack = state.getExeStack();
            stack.push(statement);
            state.setExeStack(stack);
            return null;
        }
        else{
            throw new MyException("Please insert a boolean expression in an if statement. ");
        }
    }
    @Override
    public IStmt deepCopy(){
        return new IfStmt(exp.deepCopy(),thenS.deepCopy(),elseS.deepCopy());
    }

    @Override
    public String toString(){
        return "if "+this.exp.toString()+" "+this.thenS.toString()+" else "+this.elseS.toString();
    }
}
