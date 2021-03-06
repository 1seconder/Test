/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package com.newenv.lpzd.fed;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class LPZDFederationServlet extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = -9019993850246851112L;

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
//    	String action = request.getParameter("action");
//    	if(action!=null && action.equals("getLoginUser")){
//    		PrintWriter out = response.getWriter();
//         out.println(((FederationPrincipal)request.getUserPrincipal()).getClaims().get(2).getValue().toString());
//    	}
//        response.setContentType("text/html");
//        PrintWriter out = response.getWriter();
//        out.println("<html>");
//        out.println("<head><title>WS Federation Tomcat Examples</title></head>");
//        out.println("<body>");
//        out.println("<h1>Hello World</h1>");
//        out.println("Hello world<br>");
//        out.println("Request url: " + request.getRequestURL().toString() + "<p>");
//        out.println("<br><b>User</b><p>");
//        Principal p = request.getUserPrincipal();
//        if (p != null) {
//            out.println("Principal: " + p.getName() + "<p>");
//        }
//        out.println("<br><b>Roles</b><p>");
//        List<String> roleListToCheck = Arrays.asList("Admin", "Manager", "User", "Authenticated");
//        for (String item: roleListToCheck) {
//            out.println("Has role '" + item + "': " + ((request.isUserInRole(item)) ? "<b>yes</b>" : "no") + "<p>");
//        }
//        if (p instanceof FederationPrincipal) {
//            FederationPrincipal fp = (FederationPrincipal)p;
//
//            out.println("<br><b>Claims</b><p>");
//            ClaimCollection claims = fp.getClaims();
//            for (Claim c: claims) {
//                out.println(c.getClaimType().toString() + ": " + c.getValue() + "<p>");
//            }
//        } else {
//            out.println("Principal is not instance of FederationPrincipal");
//        }
//        Element el = SecurityTokenThreadLocal.getToken();
//        if (el != null) {
//            out.println("<p>Bootstrap token...");
//            String token = null;
//            try {
//                TransformerFactory transFactory = TransformerFactory.newInstance();
//                Transformer transformer = transFactory.newTransformer();
//                StringWriter buffer = new StringWriter();
//                transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
//                transformer.transform(new DOMSource(el),
//                                      new StreamResult(buffer));
//                token = buffer.toString();
//                out.println("<p>" + StringEscapeUtils.escapeXml(token));
//            } catch (Exception ex) {
//                out.println("<p>Failed to transform cached element to string: " + ex.toString());
//            }
//        } else {
//            out.println("<p>Bootstrap token not cached in thread local storage");
//        }
//        out.println("</body>");
//    	if(request.getParameter("url")!=null)
//    		((HttpServletResponse)response).sendRedirect(request.getParameter("url").toString());
//    	else
    	if(request.getSession().getAttribute("landingUrl")!=null){
    		//request.getRequestDispatcher(request.getSession().getAttribute("landingUrl").toString()).forward(request, response);
    		((HttpServletResponse)response).sendRedirect(request.getSession().getAttribute("landingUrl").toString().replaceFirst("http", "https").replaceFirst("8080", "8443"));
    	}
    	else{
    		((HttpServletResponse)response).sendRedirect("ssoLogin.action");
    		//((HttpServletRequest)request).getRequestDispatcher("/ssoAction!sso.action?userName="+((HttpServletRequest)request).getUserPrincipal().getName()).forward(request, response);
    	}
    	
    	
    		
    	
    //	request.getRequestDispatcher("../index.jsp").forward(request, response);
  	//request.getRequestDispatcher(((HttpServletRequest)request).getRequestURL().toString().replace("https", "http").replace("8443", "8080").replace("secure/fedservlet", "index.jsp")).forward(request, response);
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	//((HttpServletResponse)response).sendRedirect(((HttpServletRequest)request).getRequestURL().toString().replace("https", "http").replace("8443", "8080").replace("secure/fedservlet", "index.jsp"));
    	if(request.getSession().getAttribute("landingUrl")!=null){
    		//request.getRequestDispatcher(request.getSession().getAttribute("landingUrl").toString()).forward(request, response);
    		((HttpServletResponse)response).sendRedirect(request.getSession().getAttribute("landingUrl").toString().replaceFirst("http", "https").replaceFirst("8080", "8443"));
    	}
    	
//    	((HttpServletResponse)response).sendRedirect("../index.jsp");
   	 //request.getRequestDispatcher(((HttpServletRequest)request).getRequestURL().toString().replace("https", "http").replace("8443", "8080").replace("secure/fedservlet", "index.jsp")).forward(request, response);
//        response.setContentType("text/html");
//        PrintWriter out = response.getWriter();
//        out.println("<html>");
//        out.println("<head><title>WS Federation Tomcat Examples</title></head>");
//        out.println("<body>");
//        out.println("<h1>Hello World</h1>");
//        out.println("Hello world<br>");
//        out.println("Request url: " + request.getRequestURL().toString() + "<p>");
//        out.println("<br><b>User</b><p>");
//        Principal p = request.getUserPrincipal();
//        if (p != null) {
//            out.println("Principal: " + p.getName() + "<p>");
//        }
//        out.println("<br><b>Roles</b><p>");
//        List<String> roleListToCheck = Arrays.asList("Admin", "Manager", "User", "Authenticated");
//        for (String item: roleListToCheck) {
//            out.println("Has role '" + item + "': " + ((request.isUserInRole(item)) ? "<b>yes</b>" : "no") + "<p>");
//        }
//        if (p instanceof FederationPrincipal) {
//            FederationPrincipal fp = (FederationPrincipal)p;
//
//            out.println("<br><b>Claims</b><p>");
//            ClaimCollection claims = fp.getClaims();
//            for (Claim c: claims) {
//                out.println(c.getClaimType().toString() + ": " + c.getValue() + "<p>");
//            }
//        } else {
//            out.println("Principal is not instance of FederationPrincipalImpl");
//        }
//        Greeter service = (Greeter)ApplicationContextProvider.getContext().getBean("HelloServiceClient");
//        String reply = service.greetMe();
//        
//        out.println("<br><b>Greeter Service Response: " + reply + "</b><p>");
//        out.println("</body>");
    }

}
