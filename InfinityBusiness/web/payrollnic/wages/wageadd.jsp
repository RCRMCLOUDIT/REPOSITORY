<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Agregar Percepcion</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.name.focus()">
<%! 
 static final String title = "Agregar Percepcion"; 
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_charcounterJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/charcounter.js"></SCRIPT>

<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/
  
 String name 		= request.getParameter("name")==null?"":request.getParameter("name");
 String descrp 		= request.getParameter("descrp")==null?"":request.getParameter("descrp");
 String concType 	= request.getParameter("concType")==null?"F":request.getParameter("concType");

 String level1     = request.getParameter("level1")==null?"":request.getParameter("level1");
 String levelText1 = request.getParameter("levelText1")==null?"":request.getParameter("levelText1");

 String level2     = request.getParameter("level2")==null?"":request.getParameter("level2");
 String levelText2 = request.getParameter("levelText2")==null?"":request.getParameter("levelText2");         

 String seizable 	= request.getParameter("seizable")==null?"N":request.getParameter("seizable");
 
 String isAging		= request.getParameter("isAging")==null?"N":request.getParameter("isAging");
 String percent		= request.getParameter("percent")==null?"":request.getParameter("percent");
 String amount		= request.getParameter("amount")==null?"":request.getParameter("amount"); 
 String comINC		= request.getParameter("comINC")==null?"N":request.getParameter("comINC"); 
 String isVIAT		= request.getParameter("isVIAT")==null?"N":request.getParameter("isVIAT"); 

 String contextRoot = request.getParameter("contextRoot");

 String errMsg 	= null;

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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRINCDECTS('" + 
 					companyID + "',0,0,'','','','','','','','','','','','','','','','',0,'','','','1',0,'','','',0,0,'INCDEDNEW','',?,?)}"; 
 					 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="addDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="addDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="addDBBean" />
</jsp:useBean>
<%
 addDBBean.execute(); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />

<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/wages/princdects.jsp">
<INPUT type="hidden" name="action" id="action" value="INCDEDADD">
<INPUT type="hidden" name="isIncome" id="isIncome" value="Y">
<INPUT type="hidden" name="isDeduction" id="isDeduction" value="N">
<INPUT type="hidden" name="status" id="status" value="AC">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">Agregar Percepcion</TD>
    </TR>   
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Nombre</TD>
      <TD width="75%" colspan="3"><input type="text" name="name" size="50" maxlength="50" value="<%=name%>"></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Descripción</TD>
      <TD width="75%" colspan="3">      
      <textarea rows="2" cols="20" name="descrp"><%=descrp%></textarea>
      <SCRIPT>displaylimit("document.myForm.descrp",100)</SCRIPT>
      </TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Fija/Variable</TD>
      <TD width="75%" colspan="3">
      	<input type="radio" name="concType" value="F" <%=concType.equals("F")?"checked":""%>>Fijo
      	<input type="radio" name="concType" value="V" <%=concType.equals("V")?"checked":""%>>Variable
      </TD>			
    </TR>
    <TR class="pcrinfo1">
      <TD class="label">Porcentaje</TD>
      <TD><input type="text" name="percent" size="5" maxlength="5" value="<%=percent%>"></TD>			
      <TD class="label">Monto</TD>
      <TD><input type="text" name="amount" size="10" maxlength="15" value="<%=amount%>"></TD>			      
    </TR>    
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Es Antiguedad</TD>
      <TD width="75%" colspan="3">
      	<input type="radio" name="isAging" value="Y" <%=isAging.equals("Y")?"checked":""%>>Si
      	<input type="radio" name="isAging" value="N" <%=isAging.equals("N")?"checked":""%>>No
      </TD>			
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Embargable</TD>
      <TD width="75%" colspan="3">
      	<input type="radio" name="seizable" value="Y" <%=seizable.equals("Y")?"checked":""%>>Si
      	<input type="radio" name="seizable" value="N" <%=seizable.equals("N")?"checked":""%>>No
      </TD>			
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Es Comision/Incentivo?</TD>
      <TD width="75%" colspan="3">
      	<input type="radio" name="comINC" value="Y" <%=comINC.equals("Y")?"checked":""%>>Si
      	<input type="radio" name="comINC" value="N" <%=comINC.equals("N")?"checked":""%>>No
      </TD>			
    </TR>
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Es Viatico?</TD>
      <TD width="75%" colspan="3">
      	<input type="radio" name="isVIAT" value="Y" <%=isVIAT.equals("Y")?"checked":""%>>Si
      	<input type="radio" name="isVIAT" value="N" <%=isVIAT.equals("N")?"checked":""%>>No
      </TD>			
    </TR>                	                    	                   	                    	
    <TR class="pcrinfo"> 
        <TD class="label"><span class="textRed">*</span>Cuenta de Debito</TD>
      	<TD colspan="3">
            <INPUT type="hidden" name="level1" value="<%=level1%>"> 
			<INPUT size="40" name="levelText1" value="<%=Format.encodeHTML(levelText1)%>" type="text" onChange="myForm.level1.value='';" onkeypress='if(isEnterPressed()) openGLDialog("1", "", "A", "N", "<%= contextRoot %>");'>
           	<INPUT type="button" name="glButton" value=" v " onclick='openGLDialog("1", "", "A", "N", "<%= contextRoot %>");'>
          </TD>
    </TR>    	
    <TR class="pcrinfo1"> 
        <TD class="label"><span class="textRed">*</span>Cuenta de Credito</TD>
      	<TD colspan="3">
            <INPUT type="hidden" name="level2" value="<%=level2%>"> 
			<INPUT size="40" name="levelText2" value="<%=Format.encodeHTML(levelText2)%>" type="text" onChange="myForm.level2.value='';" onkeypress='if(isEnterPressed()) openGLDialog("2", "", "A", "N", "<%= contextRoot %>");'>
           	<INPUT type="button" name="glButton" value=" v " onclick='openGLDialog("2", "", "A", "N", "<%= contextRoot %>");'>
          </TD>
    </TR>        
<%
  addDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/wages/wagelist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
