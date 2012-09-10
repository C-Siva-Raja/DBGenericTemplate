<%-- 
    Document   : MainPage
    Created on : Sep 10, 2012, 2:17:40 PM
    Author     : siva raja
--%>

<%@page import="java.util.List"%>
<%@page import="com.myapp.form.MainPageForm"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="./css2/stylesheet.css" />
        <link rel="stylesheet" type="text/css" href="./css2/Profile.css" >
        <link rel="stylesheet" type="text/css" href="./css2/chromestyle.css" />
        <title>JSP Page</title>
        <script type="text/javascript">
                       
            
            
            function onPrint() {
                var sOption="toolbar=yes,location=no,directories=yes,menubar=yes,"; 
                sOption+="scrollbars=yes,width=1000,height=600,left=100,top=25"; 

                var sWinHTML = document.getElementById('printdiv').innerHTML; 

                var winprint=window.open("","",sOption); 
                winprint.document.open(); 
                winprint.document.write('<html><head>')
                winprint.document.write('<head/><body onload="window.print()">'); 
                winprint.document.write(sWinHTML); 
                winprint.document.write('<body/>');
                winprint.document.write('<html/>'); 
                winprint.document.close(); 
                winprint.focus(); 
            }
            
            function onDownloadXSL() {
                window.location="downloadindex.jsp";
            }
            function onDownloadPDF() {
                window.location="PDFDownload.jsp";
            }
            
        </script>
    </head>
    <body>


        <html:form action="/Main" method="post" >

            <table widht="100%" cellpadding="0" cellspacing="2" border="0" align="center" >

                <tr >
                    <td>Query</td>
                    <td><html:textarea property="query" cols="50" rows="3"></html:textarea></td>
                    <td colspan="2" align="center">
                        <html:submit property="submit" value="Report"/>
                        <html:reset value="Clear" ></html:reset></td>
                </tr>
            </table>

        </html:form>
        <br>
        <br>
        <div class="ADBackStyle">
            <%
                MainPageForm formdata = null;
                try {
                    formdata = ((MainPageForm) session.getAttribute("data"));
                } catch (Exception e) {
            %>
            Exception:<%=e.getMessage()%>
            <%
                    return;
                }
                if (formdata == null) {
                    return;
                }
                String statusData = formdata.getStatusMsg();
                if (statusData == null || statusData.equals("")) {
                    // return;
                } else {
                   
            %><right><table align="center"><tr><td><%=statusData%></td></tr><table></right><%
                    return;

                }


                List responseData = formdata.getRespData();
                int i = 0;
                int j = formdata.getCount();
                        %>
                        <right>
                            <a onclick="onPrint()"  ><img align="right"  width="40" height="40" style="margin-top: 7px;font-weight: bold" border="0" src="Images/5.png" /> </a>
                            &nbsp;&nbsp;<a onclick="onDownloadXSL()"  ><img align="right"  width="40" height="40" style="margin-top: 7px;font-weight: bold" border="0" src="Images/3.png" /> </a>
                             &nbsp;&nbsp;<a onclick="onDownloadPDF()"  ><img align="right"  width="40" height="40" style="margin-top: 7px;font-weight: bold" border="0" src="Images/65.png" /> </a>
                        </right>
                        <div id="printdiv">  <table widht="100%" height="50%" border="1" align="center" >





                                <%
                                    try {
                                        Iterator itr1 = responseData.iterator();
                                        while (itr1.hasNext()) {
                                            if (i == 0) {
                                %><tr class="subHead">
                                    <%   }

                                        if (i == j) {
                                            i = 0;
                                    %>
                                <tr><%                                }
                                    %><td><% out.println("" + itr1.next());
                                                i++;
                                            }

                                        } catch (Exception e) {
                                           %><td><%out.println(e.getMessage());
                                        }
                                        %>
                            </table> </div><br><br> </div>

                        </body>
                        </html>
