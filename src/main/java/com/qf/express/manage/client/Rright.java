
package com.qf.express.manage.client;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>rright complex type的 Java 类。
 * 
 * <p>以下模式片段指定包含在此类中的预期内容。
 * 
 * <pre>
 * &lt;complexType name="rright"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="child" type="{http://api.manage.express.qf.com/}rright" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="hasflag" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="ismenu" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="levelcount" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="parentid" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="rightid" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="righttext" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="righttype" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="righturl" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "rright", propOrder = {
    "child",
    "hasflag",
    "ismenu",
    "levelcount",
    "parentid",
    "rightid",
    "righttext",
    "righttype",
    "righturl"
})
public class Rright {

    @XmlElement(nillable = true)
    protected List<Rright> child;
    protected Integer hasflag;
    protected Boolean ismenu;
    protected Integer levelcount;
    protected Integer parentid;
    protected Integer rightid;
    protected String righttext;
    protected Integer righttype;
    protected String righturl;

    /**
     * Gets the value of the child property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the child property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getChild().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Rright }
     * 
     * 
     */
    public List<Rright> getChild() {
        if (child == null) {
            child = new ArrayList<Rright>();
        }
        return this.child;
    }

    /**
     * 获取hasflag属性的值。
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getHasflag() {
        return hasflag;
    }

    /**
     * 设置hasflag属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setHasflag(Integer value) {
        this.hasflag = value;
    }

    /**
     * 获取ismenu属性的值。
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isIsmenu() {
        return ismenu;
    }

    /**
     * 设置ismenu属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setIsmenu(Boolean value) {
        this.ismenu = value;
    }

    /**
     * 获取levelcount属性的值。
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getLevelcount() {
        return levelcount;
    }

    /**
     * 设置levelcount属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setLevelcount(Integer value) {
        this.levelcount = value;
    }

    /**
     * 获取parentid属性的值。
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getParentid() {
        return parentid;
    }

    /**
     * 设置parentid属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setParentid(Integer value) {
        this.parentid = value;
    }

    /**
     * 获取rightid属性的值。
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getRightid() {
        return rightid;
    }

    /**
     * 设置rightid属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setRightid(Integer value) {
        this.rightid = value;
    }

    /**
     * 获取righttext属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRighttext() {
        return righttext;
    }

    /**
     * 设置righttext属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRighttext(String value) {
        this.righttext = value;
    }

    /**
     * 获取righttype属性的值。
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getRighttype() {
        return righttype;
    }

    /**
     * 设置righttype属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setRighttype(Integer value) {
        this.righttype = value;
    }

    /**
     * 获取righturl属性的值。
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRighturl() {
        return righturl;
    }

    /**
     * 设置righturl属性的值。
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRighturl(String value) {
        this.righturl = value;
    }

}
