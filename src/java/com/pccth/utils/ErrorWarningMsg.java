/*
 * Created on 23 ��.�. 2553
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.pccth.utils;

/**
 * @author POMKUNG
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ErrorWarningMsg {
	private static String msgList[] = {
			"��ҹ������Է������������ ��سҵԴ������˹�ҷ����.",
			"���ͧ�ҡ���������㹪�ǧ���������͡��� Excel File\\n��سҵԴ��ͧ͡�ع�",
			"���ͧ�ҡ���������㹪�ǧ����Ѻ����͡��� Excel File\\n��سҵԴ��ͧ͡�ع�",
			"����ͼԴ��Ҵ�����ҧ���Թ��� ��س����Ẻ�Ӣ������ա����",
			"�������ö���Թ��õ���� ��سҵ�Դ��� ��� ���ͷӡ�á�˹�������ͺ����",
			"�������ö���͡�дѺ����֡�ҷ���ӡ����дѺ����֡�������",
			"�������ö���Թ��õ���� ���ͧ�ҡ���������㹪�ǧ�������� �����Թ�������ҷ��ҧ�ͧ�ع� ��˹����",
			"����ͼԴ��Ҵ�����ҧ���Թ��� ��س�ŧ����¹�ա����",
			"���Ҿ������੾��͹ء������ 1,2 ���;�鹷��ࢵ����֡����ҹ���ҹ�� "
	};
	
	private static String urlList[] = {
			"/jsp/SLFMenu.jsp",
			"/jsp/SLFMenuControl.jsp",
			"/jsp/SLFLoginS.jsp",
			"/html/index.html"
	};
	
	
	/**
	 * @return Returns the msgList.
	 */
	public static String[] getMsgList() {
		return msgList;
	}
	
	public static String getMsgList(int index) {
		return msgList[index];
	}
	/**
	 * @return Returns the urlList.
	 */
	public static String[] getUrlList() {
		return urlList;
	}
	
	public static String getUrlList(int index) {
		return urlList[index];
	}
}
