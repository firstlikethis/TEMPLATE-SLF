/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package SLF_TOOL;

import java.io.IOException;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pccth.utils.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
public class PageServlet extends HttpServlet implements Servlet {

    public PageServlet() {
        super();
    }

    protected void doGet(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
        // TODO Auto-generated method stub
        performTask(arg0, arg1);
    }

    protected void doPost(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
        // TODO Auto-generated method stub
        performTask(arg0, arg1);
    }

    public void performTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String app_Name = request.getContextPath();
        String url = Tools.chkNull(request.getParameter("url"));
        HttpSession session = request.getSession(true);
        RequestDispatcher dispatch = request.getRequestDispatcher(url);
        dispatch.forward(request, response);
    }
}
