<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<META http-equiv="Cache-Control" content="no-cache">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<TITLE>Agregar Cargo</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.name.focus()">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="com.cap.util.*,java.math.*" %>
<%! 
 static final String title = "Agregar Cargo"; 
 
 static final int COMPSCT_CUR 	= 1; 
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/jobprofile.js"></SCRIPT>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 *******************************************************************************/

 String name 			= request.getParameter("name")==null?"":request.getParameter("name");
 String employeeId		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String salary		 	= request.getParameter("salary")==null?"":request.getParameter("salary"); 
 String sctId		 	= request.getParameter("sctId")==null?"":request.getParameter("sctId"); 
 
 String level		 	= request.getParameter("level")==null?"":request.getParameter("level"); 
 String codeSies	 	= request.getParameter("codeSies")==null?"":request.getParameter("codeSies"); 
 String prfType		 	= request.getParameter("prfType")==null?"":request.getParameter("prfType"); 
 
 String contextRoot = request.getParameter("contextRoot");

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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRJOBPROFS('" + 
 					companyID + "',0,0,'',0,0,0,0,0,'','','','','JOBPRFNEW',?,?)}"; 
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
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/confgeneral/prjobprofs.jsp">
<INPUT type="hidden" name="action" id="action" value="JOBPRFADD">
<INPUT type="hidden" name="returnEid" id="returnEid" value="Y">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">

<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Agregar Cargo</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Descripción</TD>
      <TD width="60%"><input type="text" name="name" size="50" maxlength="50" value="<%=name%>"></TD>
    </TR>
    <TR class="pcrinfo1">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Jefe Inmediato</TD>
      <TD width="60%">
		<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
 		<INPUT type="text" class="text"	size="20" maxlength="40" name="employeeName" id="employeeName" value="<%=employeeName%>" onchange="this.form.employeeId.value='';" onkeypress='if(isEnterPressed()) receipt_search(myForm, "EMP","<%=contextRoot%>");'>
		<INPUT type="button" class="hidden-btn" name="searchEmp" value=" v " onclick='receipt_search(myForm,"EMP","<%= contextRoot %>");'>      
      </TD>
    </TR>    
    <TR class="pcrinfo">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Salario de Cargo</TD>
      <TD width="60%"><input type="text" name="salary" size="21" maxlength="21" value="<%=salary%>"></TD>
    </TR>     
    <TR class="pcrinfo1">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Gerencia-Departamento</TD>
      <TD width="60%">    
	            <SELECT size="1" name="sctId" class="text">
	            <OPTION value="" <%=sctId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfSect = addDBBean.getRowsInResult(COMPSCT_CUR);
		
   		for (int j = 0; j < numOfSect; j++) { 
 			code 	= ((BigDecimal)addDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,COMPSCT_CUR)).toString();
			descr	= (String)addDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL + 1,j,COMPSCT_CUR) + "/" + (String)addDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,COMPSCT_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=sctId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
		</TD>
	</TR>    
    <TR class="pcrinfo">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Nivel - Codigo SIES</TD>
      <TD width="60%">
        <SELECT size="1" name="level" class="text">
            <OPTION value="1" <%=level.equals("1")?"selected": ""%>>1</OPTION>
			<OPTION value="2" <%=level.equals("2")?"selected": ""%>>2</OPTION>
			<OPTION value="3" <%=level.equals("3")?"selected": ""%>>3</OPTION>
			<OPTION value="4" <%=level.equals("4")?"selected": ""%>>4</OPTION>
			<OPTION value="5" <%=level.equals("5")?"selected": ""%>>5</OPTION>
			<OPTION value="6" <%=level.equals("6")?"selected": ""%>>6</OPTION>
			<OPTION value="7" <%=level.equals("7")?"selected": ""%>>7</OPTION>
			<OPTION value="8" <%=level.equals("8")?"selected": ""%>>8</OPTION>
			<OPTION value="9" <%=level.equals("9")?"selected": ""%>>9</OPTION>
			<OPTION value="10" <%=level.equals("10")?"selected": ""%>>10</OPTION>
			<OPTION value="11" <%=level.equals("11")?"selected": ""%>>11</OPTION>
			<OPTION value="12" <%=level.equals("12")?"selected": ""%>>12</OPTION>
			<OPTION value="13" <%=level.equals("13")?"selected": ""%>>13</OPTION>			
         </SELECT>   
		<input type="text" name="codeSies" size="6" maxlength="10" value="<%=codeSies%>">      	
      </TD>
    </TR>     
    <TR class="pcrinfo1">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Tipo de Salario</TD>
      <TD width="60%">
        <SELECT size="1" name="prfType" class="text">
            <OPTION value="SM" <%=prfType.equals("1")?"selected": ""%>>Salario Minimo</OPTION>
			<OPTION value="SMG" <%=prfType.equals("2")?"selected": ""%>>Salario Minimo Guardas</OPTION>
			<OPTION value="SMR" <%=prfType.equals("3")?"selected": ""%>>Salario Minimo Relacionado</OPTION>
			<OPTION value="NSMR" <%=prfType.equals("4")?"selected": ""%>>No Salario Minimo Relacionado</OPTION>
         </SELECT>   
     	
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
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/confgeneral/jobprofilelist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
