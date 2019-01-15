package com.qf.express.manage.client;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

/**
 * This class was generated by Apache CXF 3.1.17
 * 2018-11-06T15:50:38.105+08:00
 * Generated source version: 3.1.17
 * 
 */
@WebService(targetNamespace = "http://api.manage.express.qf.com/", name = "RoleService")
public interface RoleService {

    @WebMethod
    @RequestWrapper(localName = "findAuthorityTextByRoleid", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindAuthorityTextByRoleid")
    @ResponseWrapper(localName = "findAuthorityTextByRoleidResponse", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindAuthorityTextByRoleidResponse")
    @WebResult(name = "return", targetNamespace = "")
    public java.util.List<java.lang.String> findAuthorityTextByRoleid(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.Integer arg0
    );

    @WebMethod
    @RequestWrapper(localName = "findAuthorityByRoleid", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindAuthorityByRoleid")
    @ResponseWrapper(localName = "findAuthorityByRoleidResponse", targetNamespace = "http://api.manage.express.qf.com/", className = "com.qf.express.manage.client.FindAuthorityByRoleidResponse")
    @WebResult(name = "return", targetNamespace = "")
    public java.util.List<java.lang.String> findAuthorityByRoleid(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.Integer arg0
    );
}
