package com.pccth.utils;

import java.io.InputStream;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Date;

public class SlfSignature {
	private static PrivateKey priv;
	private static PublicKey pub;
	private static String sueprk;
	private static String suepk;
	private boolean keepLog = false; 

	public static final String[] hexLookupTable =
	{ 	"00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "0A", "0B",
		"0C", "0D", "0E", "0F", "10", "11", "12", "13", "14", "15", "16", "17",
		"18", "19", "1A", "1B", "1C", "1D", "1E", "1F", "20", "21", "22", "23",
		"24", "25", "26", "27", "28", "29", "2A", "2B", "2C", "2D", "2E", "2F",
		"30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "3A", "3B",
		 "3C", "3D", "3E", "3F", "40", "41", "42", "43", "44", "45", "46", "47",
		 "48", "49", "4A", "4B", "4C", "4D", "4E", "4F", "50", "51", "52", "53",
		 "54", "55", "56", "57", "58", "59", "5A", "5B", "5C", "5D", "5E", "5F",
		 "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "6A", "6B",
		"6C", "6D", "6E", "6F", "70", "71", "72", "73",	"74", "75", "76", "77",
		"78", "79", "7A", "7B", "7C", "7D", "7E", "7F", "80", "81", "82", "83",
		"84", "85", "86", "87", "88", "89", "8A", "8B", "8C", "8D", "8E", "8F",
		"90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "9A", "9B",
		"9C", "9D", "9E", "9F", "A0", "A1", "A2", "A3", "A4", "A5", "A6", "A7",
		"A8", "A9", "AA", "AB", "AC", "AD", "AE", "AF", "B0", "B1", "B2", "B3",
		"B4", "B5", "B6", "B7", "B8", "B9", "BA", "BB", "BC", "BD", "BE", "BF",
		"C0", "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "CA", "CB",
		"CC", "CD", "CE", "CF", "D0", "D1", "D2", "D3", "D4", "D5", "D6", "D7",
		"D8", "D9", "DA", "DB", "DC", "DD", "DE", "DF", "E0", "E1", "E2", "E3",
		"E4", "E5", "E6", "E7", "E8", "E9", "EA", "EB", "EC", "ED", "EE", "EF",
		"F0", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "FA", "FB",
		"FC", "FD", "FE", "FF" };

//	public static void main(String args[]) {
//		RdSignature rdSignature = new RdSignature(true);
//
//		try {
//			Connection conn = DBUtil.getConnection(false);
//			rdSignature.genSignature(conn, "S91B0000059");
//			conn.commit();
//			System.out.println("This signature is " + rdSignature.verifySignature49(conn, "S91B0000059"));
//			conn.commit();
//			conn.close();
//		} catch (Exception e) {
//			System.out.println("Exception e =" + e);
//			e.printStackTrace();
//		}
//	}

    public SlfSignature() {
    	try {
			keepLog = (new Boolean(PccProperties.getResourceString("SignatureLog"))).booleanValue();
    	} catch (Exception ex) {
			System.out.println("*****************************************");
			System.out.println("Exception in Rdsignature Constructor : \n" + ex.getMessage());
			System.out.println("*****************************************");
    	} 
    }

    public SlfSignature(boolean keepLog) {
    	this.keepLog = keepLog;
    }

	public String genSignature(Connection conn, String sys_ref_no, String data) throws Exception {
		return genSignature(conn, sys_ref_no);
	}

	public String genSignature(Connection conn, String sys_ref_no) throws Exception {
		getKeyPair();

        /* Create a Signature object and initialize it with the private key */
		Signature dsa = Signature.getInstance("SHA1withDSA", "SUN"); 
        dsa.initSign(priv);

        /* Update and sign the data */
        String data = getData(conn, sys_ref_no);
        byte[] buffer = data.getBytes();
        dsa.update(buffer, 0, buffer.length);

        /* Now that all the data to be signed has been read in, generate a signature for it */
        byte[] realSig = dsa.sign();
        String signature = hexEncode(realSig);

		insertSignature(conn, sys_ref_no, signature);

		/* Keep signature log */
        if (keepLog) {
        	System.out.println("Signature log ---> SysRefNo = " + sys_ref_no);
        	System.out.println("Signature log ---> Data = " + data);
        	System.out.println("Signature log ---> Signature = " + signature);
        }
		return signature;
	}

	public String getSignature(Connection conn, String sys_ref_no) throws Exception {
		return selectSignature(conn, sys_ref_no);
	}

	public String getSignature49(Connection conn, String sys_ref_no) throws Exception {
		return selectSignature49(conn, sys_ref_no);
	}

	public boolean verifySignature(Connection conn, String sys_ref_no) throws Exception {
        String data = getData(conn, sys_ref_no);
        String signature = selectSignature(conn, sys_ref_no);

		byte[] encKey = hexDecode(suepk);  
        X509EncodedKeySpec pubKeySpec = new X509EncodedKeySpec(encKey);

        KeyFactory keyFactory = KeyFactory.getInstance("DSA", "SUN");
        PublicKey pubKey = keyFactory.generatePublic(pubKeySpec);

        /* input the signature bytes */
        byte[] sigToVerify = hexDecode(signature);

        /* create a Signature object and initialize it with the public key */
        Signature sig = Signature.getInstance("SHA1withDSA", "SUN");
        sig.initVerify(pubKey);

        /* Update and verify the data */
        byte[] buffer = data.getBytes();
        sig.update(buffer, 0, buffer.length);

        return sig.verify(sigToVerify);
	} 

	public boolean verifySignature49(Connection conn, String sys_ref_no) throws Exception {
		String data = getData(conn, sys_ref_no);
		String signature = selectSignature49(conn, sys_ref_no);

		getKeyPair();
		/* input the signature bytes */
		byte[] sigToVerify = hexDecode(signature);

		/* create a Signature object and initialize it with the public key */
		Signature sig = Signature.getInstance("SHA1withDSA", "SUN");
		sig.initVerify(pub);

		/* Update and verify the data */
		byte[] buffer = data.getBytes();
		sig.update(buffer, 0, buffer.length);

		return sig.verify(sigToVerify);
	} 

	private synchronized void getKeyPair() throws Exception {
		String signature = "";
		Connection conn = DBUtil.getConnection(false);
		String sql = "LOCK TABLE slf.certificate_key IN EXCLUSIVE MODE";

		if (sueprk == null || sueprk == null) {
			Statement stmt = conn.createStatement();
			stmt.execute(sql);  // Lock Table

			sql = "select prv_key, pub_key from slf.certificate_key ";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				sueprk = rs.getString("prv_key");
				suepk = rs.getString("pub_key");
				rs.close();

				KeyFactory keyFactory = KeyFactory.getInstance("DSA", "SUN");
				byte[] encKey = hexDecode(sueprk);  
				PKCS8EncodedKeySpec privKeySpec = new PKCS8EncodedKeySpec(encKey);
				priv = keyFactory.generatePrivate(privKeySpec);

				encKey = hexDecode(suepk);  
				X509EncodedKeySpec pubKeySpec = new X509EncodedKeySpec(encKey);
				pub = keyFactory.generatePublic(pubKeySpec);
			} else {
				generateKeyPair();
				sql = "insert into slf.certificate_key values('" + sueprk + "', '" + suepk + "') ";
				stmt.executeUpdate(sql);
			}
			stmt.close();
			conn.commit();
		}
	}
	
	private synchronized void generateKeyPair() throws Exception {
		KeyPairGenerator keyGen;
		SecureRandom random;
		KeyPair pair;

		/* Generate a key pair */
		keyGen = KeyPairGenerator.getInstance("DSA", "SUN");
		random = SecureRandom.getInstance("SHA1PRNG", "SUN");

		keyGen.initialize(512, random);

		pair = keyGen.generateKeyPair();
		priv = pair.getPrivate();
		pub = pair.getPublic();

		/* Save the private key */
		byte[] key1 = priv.getEncoded();
		sueprk = hexEncode(key1);
       
		/* Save the public key */
		byte[] key2 = pub.getEncoded();
		suepk = hexEncode(key2);
	}
	
	private PrivateKey getPrivateKey(Connection conn, String sys_ref_no) throws Exception {
        selectSignature(conn, sys_ref_no);

		byte[] encKey = hexDecode(sueprk);  
        PKCS8EncodedKeySpec privKeySpec = new PKCS8EncodedKeySpec(encKey);

        KeyFactory keyFactory = KeyFactory.getInstance("DSA", "SUN");
        PrivateKey privKey = keyFactory.generatePrivate(privKeySpec);
        return privKey;
	}

	private PublicKey getPublicKey(Connection conn, String sys_ref_no) throws Exception {
		selectSignature(conn, sys_ref_no);

		byte[] encKey = hexDecode(suepk);  
        X509EncodedKeySpec pubKeySpec = new X509EncodedKeySpec(encKey);

        KeyFactory keyFactory = KeyFactory.getInstance("DSA", "SUN");
        PublicKey pubKey = keyFactory.generatePublic(pubKeySpec);
        return pubKey;
	}

	private void insertSignature (Connection conn, String sys_ref_no, String signature) throws Exception {
		Day today = new Day();
		today.setYearType('e');
		String sql = "insert into slf.signature49 values('" + sys_ref_no + "', '" +
				signature + "', '" + today.toString() + "')";
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		stmt.close();
	}

	private String selectSignature (Connection conn, String sys_ref_no) throws Exception {
		String signature = "";
		String sql = "select public_key, signature from slf.signature " +
				"where sys_ref_no = '" + sys_ref_no + "'";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			suepk = rs.getString("public_key");
			signature = rs.getString("signature");
		} else {
			suepk = "";
		}
		stmt.close();
		return signature;
	}

	private String selectSignature49 (Connection conn, String sys_ref_no) throws Exception {
		String signature = "";
		String sql = "select signature from slf.signature49 " +
				"where sys_ref_no = '" + sys_ref_no + "'";
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		if (rs.next()) {
			signature = rs.getString("signature");
		}
		stmt.close();
		return signature;
	}

	public String getData(Connection conn, String sys_ref_no) throws Exception {
		StringBuffer data = new StringBuffer("");
		String formCode = sys_ref_no.substring(0, 3);

		String sql = "select tin, send_form_date, marry_status, assbl_inc, net_inc, indc_tot_tax, tot_tax, " +
							"spo_assbl_inc, tot_exc_amt from slf.pnd91 where sys_ref_no = '" +
							sys_ref_no + "' and joint_flag = 'F'";

		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		ResultSetMetaData rsmd = rs.getMetaData();	
		int colNum = rsmd.getColumnCount();
		if (rs.next()) {
			for (int i = 1; i <= colNum; i++) {
				data.append(getValue(rsmd, rs, i).trim());
				data.append("|");
			}
		}
		stmt.close();
		return data.toString();
	}

	private String getValue(ResultSetMetaData rsmd, ResultSet rs, int k) throws Exception {
		String returnValue = " ";
		try{
			switch(rsmd.getColumnType(k)){
				case Types.BINARY:
					InputStream is = rs.getBinaryStream(k);
					if (rs.wasNull() == false)
						returnValue = is.toString();
					break;

				case Types.BIT:
					byte b = rs.getByte(k);
					if (rs.wasNull() == false)
						returnValue = "" + b;
					break;

	       		case Types.TINYINT:
	       		case Types.SMALLINT:
	       		case Types.INTEGER:
					int i1 = rs.getInt(k);
					if (rs.wasNull() == false)
						returnValue = Tools.dtoa(i1, "0");
					break;

	       		case Types.FLOAT:
	       		case Types.REAL:
	       		case Types.DOUBLE:
				case Types.NUMERIC:
	       		case Types.DECIMAL:
					double d2 = rs.getDouble(k);
					if (rs.wasNull() == false)
						returnValue = Tools.dtoa(d2, "0.00");
					break;

	       		case Types.CHAR:
	       		case Types.VARCHAR:
					String s = rs.getString(k);
					if (rs.wasNull() == false)
						returnValue = s;
					break;

				case Types.DATE:
					Date d1 = rs.getDate(k);
					if (rs.wasNull() == false)
						returnValue = d1.toString();
					break;

				case Types.TIME:
					Time t = rs.getTime(k);
					if (rs.wasNull() == false)
						returnValue = t.toString();
					break;

	       		case Types.TIMESTAMP:
					Timestamp ts = rs.getTimestamp(k);
					if (rs.wasNull() == false)
						returnValue = ts.toString();
					break;

	       		case Types.OTHER:
					Object o = rs.getObject(k);
					if (rs.wasNull() == false)
						returnValue = o.toString();
					break;

	       		default:
					break;
			}
		}catch(Exception e){
	        System.out.println("Error in getData: "+e.getMessage());
	        throw(e);
		}
		return returnValue;
	}

/**
 * A convenience method to convert an array of bytes to a String. We do
 * this simply by converting each byte to two hexadecimal digits.
 * Something like Base 64 encoding is more comapct, but harder to encode.
 **/
	public static String hexEncode(byte[] bytes) {
		StringBuffer stringbuffer = new StringBuffer(bytes.length * 2);
		for (int i = 0; i < bytes.length; i++) {
			stringbuffer.append(hexLookupTable[0xff & bytes[i]]);
		}
		return stringbuffer.toString();
	}

/**
 * A convenience method to convert in the other direction, from a string
 * of hexadecimal digits to an array of bytes.
 **/
	public static byte[] hexDecode( String string ) {
		int len = string.length();
		byte[] bytes = new byte[len/2];

		try {
			for (int i = 0; i < bytes.length; i++) {
				int digit = Integer.parseInt(string.substring(2 * i, (2 * i) + 2), 16);
				bytes[i] = (byte)digit;
			}
		}
		catch (Exception e) {
			System.out.println("Exception in hexDecode: " + e);
		}
		return bytes;
	}
}
