/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.form;

import java.util.List;

/**
 *
 * @author pradeep
 */
public class MainPageForm extends org.apache.struts.action.ActionForm {

    private List respData;
    private String query;
    private int count;
    private String downloadData;
    private String statusMsg;

    public String getStatusMsg() {
        return statusMsg;
    }

    public void setStatusMsg(String statusMsg) {
        this.statusMsg = statusMsg;
    }

    public String getDownloadData() {
        return downloadData;
    }

    public void setDownloadData(String downloadData) {
        this.downloadData = downloadData;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public List getRespData() {
        return respData;
    }

    public void setRespData(List respData) {
        this.respData = respData;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }
}
