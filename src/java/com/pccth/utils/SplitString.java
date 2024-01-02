package com.pccth.utils;

import java.util.ArrayList;

public class SplitString {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String  str = MS874ToUnicode("เชลซีเตรียมมีสิทธิ์มีเสียง ในการออก      เสียงแสดงความคิดเห็น ในเวทียุโรป บ้างแล้วหลังมิเชลพลาตินี่ประธานยูฟ่ามีแนวโน้ม " +
				"ว่าจะใส่ชื่อเป็นสมาชิกใหม่ รายล่าสุด..");
		System.out.println("str = " + str);
		String[] temp1 = process(str,40);
		for (int i = 0;i<temp1.length;i++){
			if(temp1[i].length()!=0){
				System.out.println(" list["+i+"] = " + "'"+temp1[i]+"'" + " and length = " + temp1[i].length());
			}
		}
	}
	
	public static String[] process(String str,int sp){
		String[] temp1 = str.split(" ");
		ArrayList list = new ArrayList();
		ArrayList l = new ArrayList();
		String[] re = null;
		//check input
		for (int i = 0;i<temp1.length;i++){
			if(temp1[i].length()!=0){
				l.add(temp1[i]);
			}
		}
		if(l.size() > 0){
			int index = 0;
			int end = l.size();
			String t = "";
			while(index!=end){
				String t2 = (String)l.get(index);
				 
				if(t2.length()>=sp){
					if(t.equals("")){
						t = t2.substring(0,sp-1);
					}else{
						list.add(t);
						if(index + 1 == end){
							list.add(t2);
						}else{
							t = t2.substring(0,sp-1);
							if(index + 1 == end){
								list.add(t);
							}
						}
					}
				}else if(t2.length() < sp){
					if(t.equals("")){
						t = t2;
					}else{
						if(t.length() + t2.length() + 1 <= sp){
							t = t + " "+ t2;
							if(index + 1 == end){
								list.add(t);
							}
						}else if(t.length() + t2.length() + 1 > sp){
							list.add(t);
							if(index + 1 == end){
								list.add(t2);
							}else{
								t = t2;
							}
						}
					}
				}
				index++;
			}
			re = new String[list.size()];
			for(int i = 0;i<list.size();i++){
				String d = (String)list.get(i);
				re[i] = d;
			}
		}
		return re;
	}
	
    public static String MS874ToUnicode(String s) {
        if (s == null)
            return "";

        StringBuffer stringbuffer = new StringBuffer(s);
        for (int i = 0; i < s.length(); i++) {
            char c = stringbuffer.charAt(i);
            if ('\241' <= c && c <= '\373')
                stringbuffer.setCharAt(i, (char)(c + 3424));
        }

        return stringbuffer.toString();
    }
}

