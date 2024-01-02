package com.pccth.utils;

import java.io.File;
import java.io.FileWriter;
import java.io.RandomAccessFile;

public class Counter {
	static private Counter instance;
	private int counter = -1;

	private Counter() {
		if (counter == -1)
			counter = getCounter("counter.txt");
	}

	public static synchronized Counter getInstance() {
		if (instance == null) {
			instance = new Counter();
		}
		return instance;
	}

	public synchronized int getCounter() {
		return counter;
	}

	public synchronized int setCounter(int c) {
		counter = c;
		try {
            FileWriter ctFile = new FileWriter("counter.txt", false);
            ctFile.write(Integer.toString(counter) + "\n");
            ctFile.close();
        } catch(Exception exception) {
            System.out.println(exception.toString());
        }

		return counter;
	}

	public synchronized int incCounter() {
		try {
            FileWriter ctFile = new FileWriter("counter.txt", false);
            ctFile.write(Integer.toString(++counter) + "\n");
            ctFile.close();
        } catch(Exception exception) {
            System.out.println(exception.toString());
        }

		return counter;
	}

    private synchronized int getCounter(String s)
    {
        try {
            File file = new File(s);
            if(!file.canRead()) {
                FileWriter ctFile = new FileWriter(s, false);
                ctFile.write("0\n");
                ctFile.close();
            }

            RandomAccessFile randomaccessfile = new RandomAccessFile(s, "rw");
            String s1 = randomaccessfile.readLine();
            randomaccessfile.close();

            if(s1.length() == 0)
                s1 = "0";
            return Integer.parseInt(s1);
        } catch(Exception exception) {
            System.out.println(exception.toString());
        }
        return 0;
    }
}
