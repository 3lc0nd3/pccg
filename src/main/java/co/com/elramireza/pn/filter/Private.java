package co.com.elramireza.pn.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with Edward L. Ramirez A.
 * cel 300 554 3367
 * email elramireza@gmail.com
 * User: usuariox
 * Date: 19/02/15
 * Time: 10:14 PM
 * To change this template use File | Settings | File Templates.
 */
public class Private implements Filter {
    String m_dispatcher="/error";

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        try{
            String requestURI = ((HttpServletRequest)req).getRequestURI();
            System.out.println("requestURI Filter = " + requestURI);
            if (requestURI.contains("h_") && requestURI.contains(".jsp")) {
                ((HttpServletResponse)resp).sendRedirect(m_dispatcher);
            } else {
                chain.doFilter(req,resp);
            }
        }catch(Exception e){
            System.out.println("Error filtrando privados "+m_dispatcher+" "+e);
        }
    }

    public void init(FilterConfig config) throws ServletException {
        String str=config.getInitParameter("dispatcher");
        if(str!=null)
            m_dispatcher=str;
    }

}
