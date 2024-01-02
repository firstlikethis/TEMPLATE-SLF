/**
 * Program CryptURL
 * @version 1.0 (03/04/2546)
 * @author Mr. Wattana Thanachavengskul
 */

package com.pccth.utils; 
import java.io.UnsupportedEncodingException;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
public class CryptURL
{
	private CryptURL(){}
	public static String ENC(String UrlString){
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(UrlString.getBytes());
	}
	public static String DEC(String UrlString){
			BASE64Decoder decoder = new BASE64Decoder();
            try {
                // Decode base64 to get bytes
                byte[] dec = decoder.decodeBuffer(UrlString);
                return new String(dec, "TIS-620");
            } catch (UnsupportedEncodingException e) {
            } catch (java.io.IOException e) {
            }
            return null;      
	}


}
