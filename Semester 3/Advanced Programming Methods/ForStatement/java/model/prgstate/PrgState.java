package model.prgstate;

import model.ADT.*;
import model.exceptions.MyException;
import model.statement.IStmt;
import model.value.Value;

import java.io.BufferedReader;

public class PrgState {
    MyIStack<IStmt> exeStack;
    MyIDictionary<String, Value> symTable;
    MyIList<Value> out;
    IStmt originalProgram;

    MyIDictionary<String, BufferedReader> fileTable;

    MyIHeap heap;
    private int id;
    private static int lastId=0;

    public MyILockTable getLockTable() {
        return LockTable;
    }

    public void setLockTable(MyILockTable lockTable) {
        LockTable = lockTable;
    }

    //TODO new added global table
    MyILockTable LockTable ;


    public PrgState(MyIStack<IStmt> stk, MyIDictionary<String, Value>symtbl, MyIList<Value> ot, IStmt prg, MyIDictionary<String, BufferedReader> fileTable, MyIHeap heap,MyILockTable lockTable){
        this.exeStack=stk;
        this.symTable=symtbl;
        this.out=ot;
        this.fileTable=fileTable;
        this.heap=heap;
        this.originalProgram=prg.deepCopy();
        this.exeStack.push(this.originalProgram);
        this.id=setId();
        this.LockTable=lockTable;
        //stk.push(prg);
    }

    public PrgState(MyIStack<IStmt> stack, MyIDictionary<String,Value> symTable, MyIList<Value> out, MyIDictionary<String, BufferedReader> fileTable, MyIHeap heap,MyILockTable lockTable) {
        this.exeStack = stack;
        this.symTable = symTable;
        this.out = out;
        this.fileTable = fileTable;
        this.heap = heap;
        this.LockTable=lockTable;
        this.id = setId();
    }
    public synchronized int setId() {
        lastId++;
        return lastId;
    }

    public int getId() {
        return this.id;
    }


    public MyIStack<IStmt> getExeStack() {

        return exeStack;
    }

    public MyIHeap getHeap() {
        return heap;
    }

    public void setHeap(MyIHeap heap) {
        this.heap = heap;
    }

    public MyIDictionary<String, Value> getSymTable() {

        return symTable;
    }

    public MyIList<Value> getOut() {

        return out;
    }

    public IStmt getOriginalProgram() {

        return originalProgram;
    }


    public MyIDictionary<String, BufferedReader> getFileTable() {
        return fileTable;
    }

    public void setFileTable(MyIDictionary<String, BufferedReader> fileTable) {
        this.fileTable = fileTable;
    }
    public void setExeStack(MyIStack<IStmt> exeStack) {

        this.exeStack = exeStack;
    }

    public void setSymTable(MyIDictionary<String, Value> symTable) {

        this.symTable = symTable;
    }

    public void setOut(MyIList<Value> out) {

        this.out = out;
    }

    public void setOriginalProgram(IStmt originalProgram) {

        this.originalProgram = originalProgram;
    }

    public boolean isNotCompleted(){
        return exeStack.isEmpty();
    }

    public PrgState oneStep() throws MyException {
        if(exeStack.isEmpty())
            throw new MyException("PrgState stack is empty.");
        IStmt crtStmt=exeStack.pop();
        //state.setExeStack(stk);
        return crtStmt.execute(this);
    }
    @Override
    public String toString(){
        return "Id: " + id + "\nExecution stack: \n" + this.exeStack.getReversed() + "\nSymbol table: \n" + this.symTable.toString() + "\nOutput list: \n" + this.out.toString() + "\nFile table:\n" + this.fileTable.toString() + "\nHeap memory:\n" + this.heap.toString() + "\n";}
}
