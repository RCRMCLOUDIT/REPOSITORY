<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Crear Nomina</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.descrp.focus()">
<%! 
 static final String title = "Crear Nomina"; 

 static final int PAYROLL_CUR  = 1; 
 static final int CURRENCY_CUR = 2;
 static final int EMPLTYPE_CUR = 3;
 
 static final int PYMEMO_COLUMN 		= 2;
 static final int PYEMPLTYPE_COLUMN 	= 3;
 static final int PYCURRID_COLUMN 		= 4; 
 static final int PYNEWDATE_COLUMN 		= 5;
 static final int PYDTFROM_COLUMN		= 6;
 static final int PYDTTO_COLUMN 		= 7;            
 static final int PYCREATBY_COLUMN 		= 8;
 static final int PYCREATBYNM_COLUMN 	= 9;         
 static final int PYCHECKBY_COLUMN	 	= 10;
 static final int PYCHECKBYNM_COLUMN 	= 11;         
 static final int PYAUTOBY_COLUMN 		= 12;
 static final int PYAUTOBYNM_COLUMN 	= 13;           
 static final int PYPAYBY_COLUMN 		= 14;
 static final int PYPAYBYNM_COLUMN 		= 15;
 static final int PYDECPAY_COLUMN 		= 16;               
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/mainpayroll.js"></SCRIPT>

<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/
 String payrollId   = request.getParameter("payrollId")==null?"":request.getParameter("payrollId"); 
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String payrollType	= request.getParameter("payrollType")==null?"":request.getParameter("payrollType");

 String emplType	= request.getParameter("emplType")==null?"":request.getParameter("emplType");

 String currId   = request.getParameter("currId")==null?"":request.getParameter("currId");
 String cratDT	 = request.getParameter("cratDT")==null?"":request.getParameter("cratDT");         

 String from	= request.getParameter("from")==null?"":request.getParameter("from");         
 String to	 	= request.getParameter("to")==null?"":request.getParameter("to");         

 String creatById 	= request.getParameter("creatById")==null?"":request.getParameter("creatById");
 String creatByNm 	= request.getParameter("creatByNm")==null?"":request.getParameter("creatByNm"); 

 String checkById 	= request.getParameter("checkById")==null?"":request.getParameter("checkById");
 String checkByNm 	= request.getParameter("checkByNm")==null?"":request.getParameter("checkByNm"); 
 
 String autById 	= request.getParameter("autById")==null?"":request.getParameter("autById");
 String autByNm 	= request.getParameter("autByNm")==null?"":request.getParameter("autByNm");
 
 String payById 	= request.getParameter("payById")==null?"":request.getParameter("payById");
 String payByNm 	= request.getParameter("payByNm")==null?"":request.getParameter("payByNm");  
  
 String pyDecPay 	= request.getParameter("pyDecPay")==null?"":request.getParameter("pyDecPay");
  
 String contextRoot = request.getContextPath();

 String errMsg 	= null;
 String code 	= "";	
 String descr 	= "";

 /*******************************************************************************
 * In case we are comming from the command page due some error, the addCommandDBBean
 * object already exists from that page. It must be create in request scope
 *******************************************************************************/
 if (returnWithError.equals("Y"))
 {
       errMsg = (String)request.getAttribute("ErrorMessage");
 }
 
  /*******************************************************************************
 * build the sqlString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCRTPARS('" + 
 					companyID + "'," + companyEID + "," + payrollId +",'','',0,'','','','','',0,0,0,0,'EDTPYR',?,?)}";  
 					 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="updateDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="updateDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="updateDBBean" />
</jsp:useBean>
<%
 updateDBBean.execute(); 
 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<%
 if (returnWithError.equals("N"))
 { 
	 try
	 {
		descrp 		= (String)updateDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,0,PAYROLL_CUR).toString().trim();
		emplType	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PYEMPLTYPE_COLUMN,0,PAYROLL_CUR)).toString().trim();
		currId   	= (String)updateDBBean.valueAtColumnRowResult(PYCURRID_COLUMN,0,PAYROLL_CUR).toString().trim();
		
		cratDT		= Format.date_Str(updateDBBean.valueAtColumnRowResult(PYNEWDATE_COLUMN,0,PAYROLL_CUR).toString());
		from		= Format.date_Str(updateDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,0,PAYROLL_CUR).toString());
		to	 		= Format.date_Str(updateDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,0,PAYROLL_CUR).toString());

		creatById 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PYCREATBY_COLUMN,0,PAYROLL_CUR)).toString().trim();
		creatByNm 	= (String)updateDBBean.valueAtColumnRowResult(PYCREATBYNM_COLUMN,0,PAYROLL_CUR).toString().trim(); 

		checkById 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PYCHECKBY_COLUMN,0,PAYROLL_CUR)).toString().trim();
		checkByNm 	= (String)updateDBBean.valueAtColumnRowResult(PYCHECKBYNM_COLUMN,0,PAYROLL_CUR).toString().trim(); 
 
		autById 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PYAUTOBY_COLUMN,0,PAYROLL_CUR)).toString().trim();
		autByNm 	= (String)updateDBBean.valueAtColumnRowResult(PYAUTOBYNM_COLUMN,0,PAYROLL_CUR).toString().trim();
 
		payById 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(PYPAYBY_COLUMN,0,PAYROLL_CUR)).toString().trim();
		payByNm 	= (String)updateDBBean.valueAtColumnRowResult(PYPAYBYNM_COLUMN,0,PAYROLL_CUR).toString().trim();

 		pyDecPay 	= (String)updateDBBean.valueAtColumnRowResult(PYDECPAY_COLUMN,0,PAYROLL_CUR).toString().trim();

		if(pyDecPay.trim().equals(""))
		{
			pyDecPay = "N";
		}
	 }catch (java.lang.ArrayIndexOutOfBoundsException e){  }
}		 
%>
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/mainpayroll/prcrtpars.jsp">
<INPUT type="hidden" name="action" id="action" value="UPDPYR">
<INPUT type="hidden" name="payrollId" id="payrollId" value="<%=payrollId%>">
<INPUT type="hidden" name="returnEid" value="Y">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Crear Nomina</TD>
    </TR>   
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Descripción</TD>
      <TD width="75%" colspan="3"><input type="text" name="descrp" size="50" maxlength="50" value="<%=descrp%>"></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Tipo de Empleado</TD>
      <TD>
	            <SELECT size="1" name="emplType" class="text">
	            <OPTION value="" <%=emplType.length()==0?"selected": ""%>></OPTION>
<%
		int numOfEmplyTyp = updateDBBean.getRowsInResult(EMPLTYPE_CUR);
		
   		for (int j = 0; j < numOfEmplyTyp; j++) { 
 			code 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,EMPLTYPE_CUR)).toString().trim();
			descr	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,EMPLTYPE_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=emplType.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      
      </TD>	
    </TR>
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Moneda</TD>
      <TD>
	            <SELECT size="1" name="currId" class="text">
	            <OPTION value="" <%=currId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfCurr = updateDBBean.getRowsInResult(CURRENCY_CUR);
		
   		for (int j = 0; j < numOfCurr; j++) { 
 			code 	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,CURRENCY_CUR).toString();
			descr	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,CURRENCY_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=currId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      
      </TD>					      
    </TR>   
   <TR class="pcrinfo1"> 
   	  <TD class="label">Fecha de Emision</TD>	
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="cratDT" class="pcrInfo" value="<%=cratDT%>" onKeyUp="addSlash(myForm.cratDT)" onChange="formatDate(myForm.cratDT)" onKeyPress="OnlyDigits();addSlash(myForm.cratDT)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.cratDT, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>
   </TR>
   <TR class="pcrinfo">     
   	  <TD class="label">Comprende Desde</TD>	
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="from" class="pcrInfo" value="<%=from%>" onKeyUp="addSlash(myForm.from)" onChange="formatDate(myForm.from)" onKeyPress="OnlyDigits();addSlash(myForm.from)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.from, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>    
    </TR>
    <TR class="pcrinfo1">
      <TD class="label">Comprende Hasta</TD>	
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="to" class="pcrInfo" value="<%=to%>" onKeyUp="addSlash(myForm.to)" onChange="formatDate(myForm.to)" onKeyPress="OnlyDigits();addSlash(myForm.to)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.to, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>        
    </TR>
    <TR class="pcrinfo">
      <TD class="label">Pago de Aguinaldo</TD>	
      <TD>
      	<input type="radio" name="pyDecPay" value="Y" <%=pyDecPay.equals("Y")?"checked":""%>> Yes
      	<input type="radio" name="pyDecPay" value="N" <%=pyDecPay.equals("N")?"checked":""%>> No
 	  </TD>        
    </TR>        
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Elaborado Por</TD>
      <TD colspan="3">
		<INPUT type="hidden" name="creatById" id="creatById" value="<%=creatById%>">
 		<INPUT type="text" class="text"	size="20" maxlength="40" name="creatByNm" id="creatByNm" value="<%=creatByNm%>" onchange="this.form.creatById.value='';" onkeypress='if(isEnterPressed()) creatBy_search(myForm, "EMP","<%=contextRoot%>");'>
		<INPUT type="button" name="searchEmp" value=" v " onclick='creatBy_search(myForm,"EMP","<%= contextRoot %>");'>      
      </TD> 
     </TR> 
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Revisado Por</TD>
      <TD colspan="3">
		<INPUT type="hidden" name="checkById" id="checkById" value="<%=checkById%>">
 		<INPUT type="text" class="text"	size="20" maxlength="40" name="checkByNm" id="checkByNm" value="<%=checkByNm%>" onchange="this.form.checkById.value='';" onkeypress='if(isEnterPressed()) checkBy_search(myForm, "EMP","<%=contextRoot%>");'>
		<INPUT type="button" name="searchEmp" value=" v " onclick='checkBy_search(myForm,"EMP","<%= contextRoot %>");'>      
      </TD> 
     </TR>      
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Autorizado Por</TD>
      <TD colspan="3">
		<INPUT type="hidden" name="autById" id="autById" value="<%=autById%>">
 		<INPUT type="text" class="text"	size="20" maxlength="40" name="autByNm" id="autByNm" value="<%=autByNm%>" onchange="this.form.autById.value='';" onkeypress='if(isEnterPressed()) autBy_search(myForm, "EMP","<%=contextRoot%>");'>
		<INPUT type="button" name="searchEmp" value=" v " onclick='autBy_search(myForm,"EMP","<%= contextRoot %>");'>      
      </TD> 
     </TR>   
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Pagado Por</TD>
      <TD colspan="3">
		<INPUT type="hidden" name="payById" id="payById" value="<%=payById%>">
 		<INPUT type="text" class="text"	size="20" maxlength="40" name="payByNm" id="payByNm" value="<%=payByNm%>" onchange="this.form.payById.value='';" onkeypress='if(isEnterPressed()) payBy_search(myForm, "EMP","<%=contextRoot%>");'>
		<INPUT type="button" name="searchEmp" value=" v " onclick='payBy_search(myForm,"EMP","<%= contextRoot %>");'>      
      </TD> 
     </TR>          
<%
  updateDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/mainpayroll/mainpayrolllist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
