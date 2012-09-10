<%-- 
    Document   : downloadindex
    Created on : Jan 28, 2012, 6:08:58 PM
    Author     : Bhaskar
--%>

<%@page import="com.lowagie.text.Font"%>
<%@page import="com.lowagie.text.Phrase"%>

<%@page import="com.lowagie.text.pdf.PdfPCell"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.Document"%>
<%@page import="com.lowagie.text.PageSize"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.myapp.form.MainPageForm"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FilenameFilter"%>
<%@page import="java.awt.Frame"%>
<%@page import="java.awt.FileDialog"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

    </body>
    <%
        try {
            int c = 0;
            SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy-kkmmss");
            String date = df.format(new java.util.Date());
            MainPageForm obj = (MainPageForm) session.getAttribute("data");
            if (obj == null) {
                return;
            }
            String buffer = obj.getDownloadData();
            int count = obj.getCount();

            //BEGIN
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();
            //    document.add(new Paragraph(buffer));



            PdfPTable table = new PdfPTable(count);
            StringTokenizer rowToken = new StringTokenizer(buffer, "!");
            while (rowToken.hasMoreTokens()) {
                String rowData = rowToken.nextToken();
                StringTokenizer columnToken = new StringTokenizer(rowData, ",");
                while (columnToken.hasMoreTokens()) {
                    String label = columnToken.nextToken();

                    PdfPCell cell = new PdfPCell();


                    if (c == 0) {
                        cell.setGrayFill(0.9f);
                        cell.setPhrase(new Phrase(label.toUpperCase(),
                                new Font(Font.HELVETICA, 10,
                                Font.BOLD)));
                    } else {

                        cell.setPhrase(new Phrase(label.toUpperCase(),
                                new Font(Font.HELVETICA, 10,
                                Font.NORMAL)));
                    }

                    table.addCell(cell);

                }
                table.completeRow();
                c = 1;
            }
            document.addTitle("TABLE");
            document.add(table);
            document.setPageSize(PageSize.A3);
            //END
            response.reset();
            response.setHeader("Content-disposition", "attachment; filename=" + "Reports" + date + ".pdf");
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Cache-Control", "no-cache"); // HTTP 1.1
            response.setHeader("Cache-Control", "max-age=0");

            document.close();
        } catch (Exception e) {
            //System.out.println(e);
            out.println("Error While Downloading the Report");
            // return;
        }
    %>              
</html>
