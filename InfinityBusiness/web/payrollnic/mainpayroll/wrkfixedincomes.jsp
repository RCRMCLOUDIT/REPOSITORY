<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Trabajar con Percepciones Fijas</TITLE>
</HEAD> 
 <BODY onload="javascript: document.myForm.employeeName0.focus()">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Trabajar con Percepciones Fijas";

 static final int CONDTA = 1;
 static final int INFDTA = 2;
 
 static final int PDAMOUNT_COLUMN 		= 1; 
 static final int PDPERCENT_COLUMN 		= 2;
 static final int PDNAME_COLUMN 		= 3;
 static final int PDDESC_COLUMN 		= 4;        
 
 static final int TLROWID_COLUMN 		= 1; 
 static final int TLEMPLID_COLUMN 		= 2; 
 static final int TLEMPLNM_COLUMN 		= 3; 
 static final int TLAMOUNT_COLUMN 		= 4; 
 static final int TLPERCENT_COLUMN 		= 5;                                                                  
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String payrollId = request.getParameter("payrollId")==null?"":request.getParameter("payrollId");
 String concepType= request.getParameter("concepType")==null?"I":request.getParameter("concepType");
 String fixOrVar  = request.getParameter("fixOrVar")==null?"F":request.getParameter("fixOrVar");
 
 String conceptId = request.getParameter("conceptId")==null?"":request.getParameter("conceptId");
 String action	  = request.getParameter("action")==null?"":request.getParameter("action");
 
 String controlAction = request.getParameter("controlAction")==null?"":request.getParameter("controlAction");
  
 int linesNumber = request.getParameter("linesNumber")==null?20:((new Integer(request.getParameter("linesNumber"))).intValue());

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRWRKCNPTS('" + 
 					companyID + "'," + companyEID + "," + payrollId + ",0,'',0,''," + conceptId + ",'" + concepType + "','" + fixOrVar +"','','',0,0,0,0,'','" + (action.equals("ALINES")?controlAction:action) + "','','',?,?)}"; 
 					
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/mainpayroll/";
 
String employeeId   = "";
String employeeName = ""; 	
String amount		= "";
String percent		= "";
String lineId		= "";

String cncName		= "";
String cncDesc		= "";
String cncAmount	= "";
String cncPercent	= "";
 					
 listDBBean.execute(); 

	 try
	 {
		cncName 		= (String)listDBBean.valueAtColumnRowResult(PDNAME_COLUMN,0,CONDTA).toString().trim();
		cncDesc			= (String)listDBBean.valueAtColumnRowResult(PDDESC_COLUMN,0,CONDTA).toString().trim();
		cncAmount		= ((BigDecimal)listDBBean.valueAtColumnRowResult(PDAMOUNT_COLUMN,0,CONDTA)).toString().trim();
		cncPercent		= ((BigDecimal)listDBBean.valueAtColumnRowResult(PDPERCENT_COLUMN,0,CONDTA)).toString().trim(); 		
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
	 
int detRows = 0;

//if(controlAction.equals("WRKCNCEDT"))
	detRows = listDBBean.getRowsInResult(INFDTA);	

if(detRows > 0 && !action.equals("ALINES"))
	linesNumber = detRows; 
%>
<FORM name = "myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/mainpayroll/prwrkcnpts.jsp">
<TABLE width="600" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="3">Trabajar con Percepciones Fijas</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label">Nombre Percepcion</TD>
      <TD colspan="2"><%=cncName%></TD>
	</TR>      
    <TR class="pcrinfo1">
      <TD class="label">Descripcion de Percepcion</TD>
      <TD colspan="2"><%=cncDesc%></TD> 
  	</TR>    
    <TR class="tableheader">
      <TD>Empleado</TD>
      <TD>Monto</TD>      
      <TD>Porcentaje</TD>      
    </TR>
<%
	for(int j=0;j<linesNumber;j++)
  	{ 
	try 
	{ 
		employeeId	= request.getParameter("employeeId"+j)==null?"":request.getParameter("employeeId"+j);	
		employeeName= request.getParameter("employeeName"+j)==null?"":request.getParameter("employeeName"+j);	
		amount		= request.getParameter("amount"+j)==null?"":request.getParameter("amount"+j);
		percent		= request.getParameter("percent"+j)==null?"0.00":request.getParameter("percent"+j);	
		lineId		= request.getParameter("lineId"+j)==null?String.valueOf(j):request.getParameter("lineId"+j);	

		if(action.equals("WRKCNCEDT"))
		{
			employeeId		= ((BigDecimal)listDBBean.valueAtColumnRowResult(TLEMPLID_COLUMN,j,INFDTA)).toString().trim();		
			employeeName	= (String)listDBBean.valueAtColumnRowResult(TLEMPLNM_COLUMN,j,INFDTA).toString().trim();
			amount			= ((BigDecimal)listDBBean.valueAtColumnRowResult(TLAMOUNT_COLUMN,j,INFDTA)).toString().trim();		
			percent			= ((BigDecimal)listDBBean.valueAtColumnRowResult(TLPERCENT_COLUMN,j,INFDTA)).toString().trim();			
			//lineId			= ((BigDecimal)listDBBean.valueAtColumnRowResult(TLROWID_COLUMN,j,INFDTA)).toString().trim();			
		}	
%>
    <TR class="<%=j%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap align="left">
    	<INPUT type="hidden" name="updRec<%=j%>" value="N">            
    	<INPUT type="hidden" name="lineId<%=j%>" value="<%=lineId%>">      
		<INPUT type="hidden" name="employeeId<%=j%>" id="employeeId<%=j%>" value="<%=employeeId%>">
 		<INPUT type="text" class="text"	size="50" maxlength="40" name="employeeName<%=j%>" id="employeeName<%=j%>" value="<%=employeeName%>" onchange="this.form.employeeId<%=j%>.value='';" onkeypress='if(isEnterPressed()) openSEmployeesDialog(myForm, "employeeId<%=j%>", "employeeName<%=j%>", "<%= request.getContextPath()%>","");'>
		<INPUT type="button" name="searchEmp" value=" v " onclick='openSEmployeesDialog("myForm", "employeeId<%=j%>", "employeeName<%=j%>", "<%= request.getContextPath()%>","");'>      
      </TD>    
      <TD nowrap align="right"><input class="textfield" type="text" name="amount<%=j%>" size="10" maxlength="15" value="<%=amount%>"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="percent<%=j%>" size="5" maxlength="5" value="<%=percent%>"></TD>
    </TR>  
<%
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
listDBBean.closeResultSet();
%>
    <TR>
		<TD colspan="5">
			<TABLE width="100%" border="0" cellpadding="0" cellspacing="1" height="30">
				<TR>
					<TD><INPUT type="button" name="addLines" value="<%=rb.getString("B00034")%>" class="button" onclick="document.myForm.action.value='ALINES';document.myForm.linesNumber.value='<%=linesNumber+4%>';document.myForm.submit();"></TD>
					<TD align="right" class="label"></TD>
                </TR>
            </TABLE>
		</TD>
	</TR>  
</TABLE>
<TABLE border="0" width="600" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
		  <INPUT type="hidden" name="linesNumber" id="linesNumber" value="<%=linesNumber%>">
		  <INPUT type="hidden" name="action" value="<%=detRows==0?"WRKCNCADD":"WRKCNCUPD"%>">
  		  <INPUT type="hidden" name="controlAction" value="<%=detRows==0?"WRKCNCNEW":"WRKCNCEDT"%>">		  
		  <INPUT type="hidden" name="conceptId" value="<%=conceptId%>">
		  <INPUT type="hidden" name="concepType" id="concepType" value="<%=concepType%>">
		  <INPUT type="hidden" name="conceptNM" id="conceptNM" value="<%=cncName%>">
		  <INPUT type="hidden" name="conceptDS" id="conceptDS" value="<%=cncDesc%>">		  		  
		  <INPUT type="hidden" name="fixOrVar" id="fixOrVar" value="<%=fixOrVar%>">		  
		  <INPUT type="hidden" name="payrollId" value="<%=payrollId%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30"> 
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">  
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="cancel" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/mainpayroll/wrkfixedincomeslist.jsp?payrollId=<%=payrollId%>&concepType=<%=concepType%>&contextRoot=<%=request.getContextPath()%>&fixOrVar=<%=fixOrVar%>';">
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>