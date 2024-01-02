package com.pccth.utils;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class LogFile{
	private PrintWriter pw;
	
	public LogFile() {
	}

	public LogFile(String filename) {
		try{
			pw = new PrintWriter(new FileWriter(filename, true), true);	     //  Append
			//pw = new PrintWriter(new FileWriter(filename, false), true);     // Overide
		}catch(IOException e){
			System.out.println("Error in Constructor LogFile : "+e.getMessage());
		}
	}

	public void print(String msg){
		pw.print(msg);
	}

	public void println(String msg){
		pw.println(msg);
	}
	
	public void close() {
		pw.close();
	}
}