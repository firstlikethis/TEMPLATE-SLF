/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;

/**
 *
 * @author T
 */
public class Au {

    public String getAD(String uid, String pass) {
        String ou = "";
        String tmpChk="";
        try {
            Hashtable props = new Hashtable();
            props.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            //props.put(Context.PROVIDER_URL, "ldap://10.1.10.1:389");
            props.put(Context.PROVIDER_URL, "ldap://192.168.40.2:389");
            props.put(Context.SECURITY_PRINCIPAL, uid + "@studentloan.or.th");
            //props.put(Context.SECURITY_PRINCIPAL, "OU=SLF_USER");
            //props.put(Context.SECURITY_PRINCIPAL, uid + "@studentloan.or.th,OU=SLF_USER,DC=studentloan,DC=or,DC=th");
            //props.put(Context.SECURITY_AUTHENTICATION, uid);
            props.put(Context.SECURITY_CREDENTIALS, pass);

            InitialDirContext context = new InitialDirContext(props);
            ou = context.toString();
                                    
            tmpChk="Y";
        } catch (NamingException ex) {
            //Logger.getLogger(Au.class.getName()).log(Level.SEVERE, null, ex);
            ou = "Err=" + ex.toString();
            tmpChk="N";
        }

        return tmpChk; //return ou;
    }
    
    public String getAD1(String server, String uid, String pass) {
        String ou = "";
        String tmpChk="";
        try {
            Hashtable props = new Hashtable();
            props.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            props.put(Context.PROVIDER_URL, server);
            props.put(Context.SECURITY_PRINCIPAL, uid + "@studentloan.or.th,OU=SLF_USER");
            //props.put(Context.SECURITY_PRINCIPAL, uid + "@studentloan.or.th,OU=SLF_USER,DC=studentloan,DC=or,DC=th");
            //props.put(Context.SECURITY_AUTHENTICATION, uid);
            props.put(Context.SECURITY_CREDENTIALS, pass);

            InitialDirContext context = new InitialDirContext(props);
            ou = context.toString();
            tmpChk="Y";
        } catch (NamingException ex) {
            //Logger.getLogger(Au.class.getName()).log(Level.SEVERE, null, ex);
            ou = "Err=" + ex.toString();
            tmpChk="N";
        }

        return tmpChk; //return ou;
    }

    public static void main(String[] args) {

        Au aa = new Au();
        String tmpChk;

        String b = aa.getAD("user01", "P@ssw0rd");
        
        System.out.println("AD=" + b);

    }
}
