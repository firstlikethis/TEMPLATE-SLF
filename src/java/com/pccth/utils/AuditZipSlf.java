/*
 * Created on 10 Ê.¤. 2552
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.pccth.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

/**
 * @author POMKUNG
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class AuditZipSlf {

	public static String[] Extract(String filename,String destinationpath) {
		//System.out.println("filename : " + filename+" , destination : "+destinationpath);
		String [] zipEntryNameArr = null;
		ArrayList arrEntryTmp = new ArrayList();
		try {
			byte[] buf = new byte[1024];
			ZipInputStream zipinputstream = null;
			ZipEntry zipentry;
			zipinputstream = new ZipInputStream(new FileInputStream(filename));

			zipentry = zipinputstream.getNextEntry();
			while (zipentry != null) {
				//for each entry to be extracted
				String entryName = zipentry.getName();
				System.out.println("entryname " + entryName);
				arrEntryTmp.add(entryName);
				
				int n;
				FileOutputStream fileoutputstream;
				//File newFile = new File(entryName);
				
				File dir = new File(destinationpath);
				if (dir.exists() == false)
					dir.mkdirs();

				fileoutputstream = new FileOutputStream(destinationpath + entryName);

				while ((n = zipinputstream.read(buf, 0, 1024)) > -1)
					fileoutputstream.write(buf, 0, n);

				fileoutputstream.close();
				zipinputstream.closeEntry();
				zipentry = zipinputstream.getNextEntry();

			}//while

			zipinputstream.close();
			
			if(arrEntryTmp.size() > 0){
				zipEntryNameArr = new String[arrEntryTmp.size()];
				for(int i=0;i<arrEntryTmp.size();i++){
					zipEntryNameArr[i] = (String)arrEntryTmp.get(i);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return zipEntryNameArr;
	}

	public static void Compress(String filesToZip[],String destinationFile) {
		byte[] buffer = new byte[18024];

		// Specify zip file name
		String zipFileName = destinationFile;

		try {
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFileName));

			// Set the compression ratio
			out.setLevel(Deflater.DEFAULT_COMPRESSION);

			// iterate through the array of files, adding each to the zip file
			String entryName = "";
			int indexEntry = 0;
			for (int i = 0; i < filesToZip.length; i++) {
				System.out.println(i);
				// Associate a file input stream for the current file
				FileInputStream in = new FileInputStream(filesToZip[i]);

				// Add ZIP entry to output stream.
				entryName = filesToZip[i];
				indexEntry = filesToZip[i].lastIndexOf("/");
				if(indexEntry > -1){
					entryName = filesToZip[i].substring(indexEntry+1);
				}
				out.putNextEntry(new ZipEntry(entryName));

				int len;
				while ((len = in.read(buffer)) > 0){
					out.write(buffer, 0, len);
				}

				// Close the current entry
				out.closeEntry();

				// Close the current file input stream
				in.close();
			}

			// Close the ZipOutPutStream
			out.close();
			
		}catch (IllegalArgumentException iae) {
			iae.printStackTrace();
		}catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
		}catch (IOException ioe){
			ioe.printStackTrace();
		}
	}
}

