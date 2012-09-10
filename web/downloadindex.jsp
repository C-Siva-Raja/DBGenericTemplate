<%-- 
    Document   : downloadindex
    Created on : Jan 28, 2012, 6:08:58 PM
    Author     : Bhaskar
--%>
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

<%@page import="jxl.CellView"%>
<%@page import="jxl.Workbook"%>
<%@page import="jxl.format.*"%>
<%@page import="jxl.write.Label"%>
<%@page import="jxl.write.WritableCellFormat"%>
<%@page import="jxl.write.WritableFont"%>
<%@page import="jxl.write.WritableSheet"%>
<%@page import="jxl.write.WritableWorkbook"%>
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
            SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy-kkmmss");
            String date = df.format(new java.util.Date());
            MainPageForm obj = (MainPageForm) session.getAttribute("data");
            if (obj == null) {
                return;
            }
            String buffer = obj.getDownloadData();

            WritableCellFormat times;
            WritableWorkbook workbook = Workbook.createWorkbook(response.getOutputStream());
            workbook.createSheet("Report", 0);
            WritableSheet excelSheet = workbook.getSheet(0);
            // Lets create a times font
            WritableFont times10pt = new WritableFont(WritableFont.TIMES, 10);
            // Define the cell format
            times = new WritableCellFormat(times10pt);
            //times.setBackground(Colour.GREY_25_PERCENT);
            times.setAlignment(Alignment.LEFT);
            times.setOrientation(Orientation.HORIZONTAL);
            times.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);
            // Lets automatically wrap the cells
            times.setWrap(true);
            // Create create a bold font with unterlines

            int rowCount = 0;
            int columnCount = 0;
            StringTokenizer rowToken = new StringTokenizer(buffer, "!");
            while (rowToken.hasMoreTokens()) {
                String rowData = rowToken.nextToken();
                StringTokenizer columnToken = new StringTokenizer(rowData, ",");
                while (columnToken.hasMoreTokens()) {
                    Label label = new Label(columnCount++, rowCount, columnToken.nextToken(), times);
                    excelSheet.addCell(label);
                }
                rowCount++;
                columnCount = 0;
            }
            response.reset();
            response.setHeader("Content-disposition", "attachment; filename=" + "Reports" + date + ".xls");
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Cache-Control", "no-cache"); // HTTP 1.1
            response.setHeader("Cache-Control", "max-age=0");
            workbook.write();
            workbook.close();
        } catch (Exception e) {
            //System.out.println(e);
            out.println("Error While Downloading the Report");
            // return;
        }
    %>              
</html>
