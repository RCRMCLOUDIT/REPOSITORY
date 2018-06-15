<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Editar Departamento</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.name.focus()">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="com.cap.util.*" %>
<%! 
 static final String title = "Editar Departamento"; 
 
 static final int ENTITY_CUR 	 = 1; 
 static final int DEPARTMENT_CUR = 2; 
 
 static final int AV_COLUMN			= 1; //ABBREVIATION COLUMN
 static final int NM_COLUMN			= 2; //DESCRIPTION COLUMN
 static final int CSEMPTSK_COLUMN	= 3; 
 static final int CSETID_COLUMN		= 4;
 static final int CSPROJ_COLUMN		= 5;
 static final int CSTSK1_COLUMN		= 6;
 static final int CSTSK2_COLUMN		= 7;
 static final int CC_COLUMN			= 8; //COST CENTER COLUMN 
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 *******************************************************************************/
 String tpMngrId = request.getParameter("tpMngrId")==null?"0":request.getParameter("tpMngrId");
 String tpMngrDS = request.getParameter("tpMngrDS")==null?"0":request.getParameter("tpMngrDS");

 String Id	 	= request.getParameter("Id")==null?"":request.getParameter("Id");  
 String name 	= request.getParameter("name")==null?"":request.getParameter("name");
 String abrv 	= request.getParameter("abrv")==null?"":request.getParameter("abrv");

 //Cost Center 
 String entType			= request.getParameter("entType")==null?"":request.getParameter("entType"); 
 String empCustId		= request.getParameter("empCustId")==null?"":request.getParameter("empCustId");
 String empCustIdText 	= request.getParameter("empCustIdText")==null?"":request.getParameter("empCustIdText"); 
 
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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRSETUPPYS('" + 
 					companyID + "'," + companyEID + "," + Id + ",'',''," + tpMngrId + ",'','','',0,0,'','','DEPARTEDT',?,?)}"; 
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
String task = "";
String id1  = "";
String id2  = "";
String tsk1 = "";
String tsk2 = "";

 if (returnWithError.equals("N"))
 { 
	 try
	 {
		name = (String)updateDBBean.valueAtColumnRowResult(NM_COLUMN,0,DEPARTMENT_CUR).toString().trim(); 
		abrv = (String)updateDBBean.valueAtColumnRowResult(AV_COLUMN,0,DEPARTMENT_CUR).toString().trim(); 
		task = (String)updateDBBean.valueAtColumnRowResult(CSEMPTSK_COLUMN,0,DEPARTMENT_CUR).toString().trim();
		id1  = (String)updateDBBean.valueAtColumnRowResult(CSETID_COLUMN,0,DEPARTMENT_CUR).toString().trim();
		id2  = (String)updateDBBean.valueAtColumnRowResult(CSPROJ_COLUMN,0,DEPARTMENT_CUR).toString().trim();
		tsk1 = (String)updateDBBean.valueAtColumnRowResult(CSTSK1_COLUMN,0,DEPARTMENT_CUR).toString().trim();
		tsk2 = (String)updateDBBean.valueAtColumnRowResult(CSTSK2_COLUMN,0,DEPARTMENT_CUR).toString().trim(); 
	
		if(task.equals(""))
			task = " ";
		if(id1.equals(""))
			id1 = " ";
		if(id2.equals(""))
			id2 = " ";
		if(tsk1.equals(""))
			tsk1 = "0";
		if(tsk2.equals(""))
			tsk2 = "0";
		
		entType			= CostCenterHelper.getEntityTypeCode(task);
		empCustId		= task + "©©©" + id1 + "©©©" + id2 + "©©©" + tsk1 + "©©©" + tsk2 + "©©©";
		empCustIdText 	= (String)updateDBBean.valueAtColumnRowResult(CC_COLUMN,0,DEPARTMENT_CUR);
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 }
%>
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/confgeneral/prsetuppys.jsp">
<INPUT type="hidden" name="action" id="action" value="DEPARTUPD">
<INPUT type="hidden" name="Id" id="Id" value="<%=Id%>">
<INPUT type="hidden" name="tpMngrId" id="tpMngrId" value="<%=tpMngrId%>">
<INPUT type="hidden" name="tpMngrDS" id="tpMngrDS" value="<%=tpMngrDS%>">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">

<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Agregar Departamento</TD>
    </TR>
    <TR>
      <TD colspan="2" class="tableheader">Gerencia: <%=tpMngrDS%></TD>
    </TR>    
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Descripción</TD>
      <TD width="75%"><input type="text" name="name" size="50" maxlength="50" value="<%=name%>"></TD>
    </TR>
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Abreviación</TD>
      <TD width="75%"><input type="text" name="abrv" size="5" maxlength="5" value="<%=abrv%>"></TD>
    </TR>     
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Centro de Costo</TD>
      <TD width="75%">    
	            <SELECT size="1" name="entType" class="text" onchange="myForm.empCustId.value='<%=ConstantValue.COST_CENTER_BLANK_ID%>'; myForm.empCustIdText.value='';">
	            <OPTION value="" <%=entType.length()==0?"selected": ""%>></OPTION>
<%
		int numOfEntity = updateDBBean.getRowsInResult(ENTITY_CUR);
		
   		for (int j = 0; j < numOfEntity; j++) { 
 			code 	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,ENTITY_CUR);
			descr	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,ENTITY_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=entType.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
			<INPUT type="hidden" name="empCustId" value="<%=empCustId%>">
        	<INPUT type="text" size="55" maxlength="55" name="empCustIdText" id="empCustIdText" value="<%=empCustIdText%>" onChange="myForm.empCustId.value='<%=ConstantValue.COST_CENTER_BLANK_ID%>';" onkeypress='if(isEnterPressed()) openCostCenterDialog("", "A", "<%= request.getContextPath() %>");'>
        	<INPUT type="button" name="dropBoxButtom" value=" v " onclick='openCostCenterDialog("", "A", "<%= request.getContextPath() %>");'>	               
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
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/confgeneral/departmentlist.jsp?tpMngrId=<%=tpMngrId%>&tpMngrDS=<%=tpMngrDS%>';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
