/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.action;

import com.myapp.DB.QueryDB;
import com.myapp.form.MainPageForm;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author pradeep
 */
public class MainPageAction extends org.apache.struts.action.Action {

    /*
     * forward name="success" path=""
     */
    /**
     * This is the action called from the Struts framework.
     *
     * @param mapping The ActionMapping used to select this instance.
     * @param form The optional ActionForm bean for this request.
     * @param request The HTTP Request we are processing.
     * @param response The HTTP Response we are processing.
     * @throws java.lang.Exception
     * @return
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        /*
         * initilize the variavles
         *
         */

        String RESP_MSG = "Fail";
        ResultSet resultset = null;
        String statusMSG = null;
        int count = 0;
        StringBuffer stringBuffer = new StringBuffer();



        HttpSession session = request.getSession();
        List responseDataList = new ArrayList<Hashtable>();


        MainPageForm mainPageForm = (MainPageForm) form;
        String querySelected = mainPageForm.getQuery();

        if (querySelected == null || querySelected.equals("")) {
            statusMSG = "Please Enter Query";
        } else {
            querySelected = querySelected.trim().toLowerCase();

            if (querySelected.startsWith("select")) {
                try {

                    resultset = QueryDB.SelectQuery(querySelected);
                } catch (Exception se) {
                    statusMSG = "In correct query, please check, Error Message is : " + se.getMessage();
                }
            } else if (querySelected.startsWith("drop") || querySelected.startsWith("insert")
                    || querySelected.startsWith("update") || querySelected.startsWith("delete")) {
                try {

                    count = QueryDB.getUpdate(querySelected);
           
                } catch (Exception se) {
                    statusMSG = "In correct query, please check, Error Message is : " + se.getMessage();
                }
            } else {
                statusMSG = "Invalid Query";
            }

            // 
            try {
                if (statusMSG == null) {
                    if (querySelected.startsWith("select")) {
                        ResultSetMetaData rsMetaData = resultset.getMetaData();
                        int columnCount = rsMetaData.getColumnCount();

                        for (int headcount = 1; headcount <= columnCount; headcount++) {
                            String headerValues = rsMetaData.getColumnName(headcount);
                            responseDataList.add(headerValues);
                            stringBuffer.append(headerValues + ",");
                        }
                        stringBuffer.append("!");

                        while (resultset.next()) {
                            for (int datacount = 1; datacount <= columnCount; datacount++) {
                                String values = resultset.getString(datacount);
                                responseDataList.add(values);
                                stringBuffer.append(values + ",");
                            }
                            stringBuffer.append("!");
                        }

                        mainPageForm.setCount(columnCount);
                        mainPageForm.setRespData(responseDataList);
                        mainPageForm.setDownloadData(stringBuffer.toString());

                        stringBuffer.delete(0, stringBuffer.length());

                        statusMSG = null;
                        RESP_MSG = "SELECT";
                    } else {
                        statusMSG = "Number Of Rows Updated:" + count;
                        RESP_MSG = "UPDATE";
                        mainPageForm.setStatusMsg(statusMSG);

                    }

                } else {
                    statusMSG = statusMSG;

                }
            } catch (Exception e) {
                statusMSG = "Exception:" + e.getMessage();
            }

        }
        session.setAttribute("data", mainPageForm);
        mainPageForm.setStatusMsg(statusMSG);
        return mapping.findForward(RESP_MSG);
    }
}
