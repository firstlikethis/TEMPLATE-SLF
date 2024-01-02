package com.pccth.utils;

import java.io.*;
import java.util.*;
import java.util.zip.*;

public class UnZip {
	static final int BUFFER = 2048;

	public UnZip () {}

	public static void Extract(String fileName, String pathName) {
//System.out.println(" fileName "+fileName+" \n pathName "+pathName);
		try {
			BufferedOutputStream dest = null;
			BufferedInputStream is = null;
			ZipEntry entry;			
			ZipFile zipfile = new ZipFile(fileName);
			Enumeration e = zipfile.entries();
			while(e.hasMoreElements()) {
				entry = (ZipEntry) e.nextElement();	
				is = new BufferedInputStream(zipfile.getInputStream(entry));
				int count;
				byte data[] = new byte[BUFFER];
//				String FileNameInZip = entry.getName();
//System.out.print("xx" +  FileNameInZip);				
//				FileNameInZip = FileNameInZip.substring(FileNameInZip.length()-36 ,FileNameInZip.length());
//				File file = new File(pathName + FileNameInZip );
				File file = new File(pathName + entry.getName() );
				FileOutputStream fos = new FileOutputStream(file);					
				dest = new BufferedOutputStream(fos, BUFFER);
				while ((count = is.read(data, 0, BUFFER)) != -1) {
					dest.write(data, 0, count);
				}
				dest.flush();
				dest.close();
				is.close();				
				fos.close();
//				file.delete();
			}
			zipfile.close();
		} catch(Exception e) {
			e.printStackTrace();
		}		
	}
}
