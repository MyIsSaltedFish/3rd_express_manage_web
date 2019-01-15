package com.qf.express.manage.client;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

import com.qf.express.common.AppResult;
import com.qf.express.common.DataGridResult;

/**
 * This class was generated by Apache CXF 3.1.17
 * 2018-11-06T15:41:43.605+08:00
 * Generated source version: 3.1.17
 * 
 */
@WebService(targetNamespace = "http://api.manage.express.qf.com/", name = "ExpressService")
public interface ExpressService {

    @WebMethod
    @RequestWrapper(localName = "findStacff", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindStacff")
    @ResponseWrapper(localName = "findStacffResponse", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindStacffResponse")
    @WebResult(name = "return", targetNamespace = "")
    public DataGridResult<BcStaff> findStacff(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.Integer arg0,
        @WebParam(name = "arg1", targetNamespace = "")
        java.lang.Integer arg1,
        @WebParam(name = "arg2", targetNamespace = "")
        java.lang.String arg2
    );

    @WebMethod
    @RequestWrapper(localName = "addStaff", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.AddStaff")
    @ResponseWrapper(localName = "addStaffResponse", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.AddStaffResponse")
    @WebResult(name = "return", targetNamespace = "")
    public AppResult addStaff(
        @WebParam(name = "arg0", targetNamespace = "")
        com.qf.express.manage.client.BcStaff arg0
    );

    @WebMethod
    @RequestWrapper(localName = "findAllStacff", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindAllStacff")
    @ResponseWrapper(localName = "findAllStacffResponse", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindAllStacffResponse")
    @WebResult(name = "return", targetNamespace = "")
    public DataGridResult<BcStaff> findAllStacff(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.Integer arg0,
        @WebParam(name = "arg1", targetNamespace = "")
        java.lang.Integer arg1
    );

    @WebMethod
    @RequestWrapper(localName = "updStaff", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.UpdStaff")
    @ResponseWrapper(localName = "updStaffResponse", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.UpdStaffResponse")
    @WebResult(name = "return", targetNamespace = "")
    public AppResult updStaff(
        @WebParam(name = "arg0", targetNamespace = "")
        Integer[] id
    );
}
