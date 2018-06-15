<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Percepciones</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Lista de Percepciones";

 static final int WAGES_CUR = 1;

 static final int PDCONCID_COLUMN		= 1; 
 static final int PDNAME_COLUMN			= 2; 
 static final int PDFIXED_COLUMN		= 3; 
 static final int PDVARIABL_COLUMN		= 4; 
 static final int PDSEIZABLE_COLUMN		= 6;
 static final int PDSTATUS_COLUMN		= 7;
 static final int PDISAGING_COLUMN		= 9; 
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRINCDECTS('" + 
 					companyID + "',0,0,'','','','','','','','','','','','','','','','',0,'','','','1',0,'','','',0,0,'INCDEDLST','',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;

 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/wages/";
 					
 String link1 = baseLink + "wageupd.jsp?startIndex=" + startIndex + "&Id=";
 String link2 = baseLink + "apltaxes.jsp?startIndex=" + startIndex + "&Id="; 
 String link3 = baseLink + "aginglist.jsp?startIndex=" + startIndex + "&wageId=";
  
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(WAGES_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="5">Lista de Percepciones</TD>
    </TR>
    <TR class="tableheader">
      <TD>Nombre</TD>
      <TD>Fija/Variable</TD>      
      <TD>Embargable</TD>            
      <TD>Estado</TD>      
    </TR>
<%
String wageType = "";

 if (listDBBean.RowCountResult(WAGES_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="4"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(PDCONCID_COLUMN,i,WAGES_CUR)).toString();	
		String link2s = link2 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(PDCONCID_COLUMN,i,WAGES_CUR)).toString() + "&wageName=" + (String)listDBBean.valueAtColumnRowResult(PDNAME_COLUMN,i,WAGES_CUR);	
		String link3s = link3 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(PDCONCID_COLUMN,i,WAGES_CUR)).toString();	
		
 		String isFIXED = (String)(listDBBean.valueAtColumnRowResult(PDFIXED_COLUMN,i,WAGES_CUR));
 		String isAging = (String)(listDBBean.valueAtColumnRowResult(PDISAGING_COLUMN,i,WAGES_CUR)); 
 
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	
		link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Retenciones de Ley Aplicables" + ConstantValue.END_TAG;	
		
		if(isAging.equals("Y"))
			link = link + ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Tabla de Antiguedad" + ConstantValue.END_TAG;	
		
		if(isFIXED.equals("Y"))
			wageType = "Fija";		
		else
			wageType = "Variable";		
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="left" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 200, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)listDBBean.valueAtColumnRowResult(PDNAME_COLUMN,i,WAGES_CUR)%></A></TD>    
      <TD nowrap><%=wageType%></TD>
      <TD nowrap><%=((String)listDBBean.valueAtColumnRowResult(PDSEIZABLE_COLUMN,i,WAGES_CUR)).toString().equals("Y")?"SI":"No"%></TD>      
      <TD nowrap><%=((String)listDBBean.valueAtColumnRowResult(PDSTATUS_COLUMN,i,WAGES_CUR)).toString().equals("AC")?"Activo":"Inactivo"%></TD>       
    </TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}
listDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR><TD width="30%" height="30">
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/wages/wageadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30">   
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>