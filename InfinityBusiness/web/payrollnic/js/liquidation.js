/*****************************************************
 Function to calculate Miss and Aging Amounts
 *****************************************************/
function cal_missesAmt(row)
{
	var misTotAmt = "0.00";
	var agiTotAmt = "0.00";

	var salary 		= eval("myForm.salary" + row);
	var aging		= eval("myForm.aging" + row);
	var misAmt		= eval("myForm.amountMiss" + row);
	var agmisAmt	= eval("myForm.agingMiss" + row);
	var salType		= eval("myForm.salType" + row);
	var salProm		= eval("myForm.salProm" + row);
	var missDays	= eval("myForm.daysMiss" + row);
	var sickDays	= eval("myForm.sickDays" + row);
 	var rvacDays	= eval("myForm.rvacDays" + row);
    var totDays		= eval("myForm.rwrkDays" + row);
    var wrkDays		= eval("myForm.wrkDays" + row);

	var totSalry    = "0.00";
	var wkDays		= "0";
	//alert(salType.value);
	if(salType.value == "V")
		totSalry 	= parseFloat(salProm.value);
	else
		totSalry 	= parseFloat(salary.value);

	if(salType.value == "V" && totSalry == "0.00")
		totSalry 	= parseFloat(salary.value);

	//alert(totSalry);
	//alert(missDays.value);

	if(missDays.value >= 0 && missDays.value < 16)
	{
		if(wrkDays.value != 0)
			wkDays			= wrkDays.value - missDays.value;
		else
			wkDays			= 15 - missDays.value;

		if(sickDays.value > 0)
			wkDays = wkDays - sickDays.value;

		if(rvacDays.value > 0)
			wkDays = wkDays - rvacDays.value;

		//alert(wkDays)
		//totDays.value   = 15 - rvacDays.value - sickDays.value - missDays.value - wrkDays.value;
		totDays.value   = wkDays;
		misTotAmt		= (totSalry/30) * (parseFloat(missDays.value));
		misAmt.value 	= formatCurrency(misTotAmt);
	}
	else if(missDays.value > 15)
	{
		if(wrkDays.value != 0)
			totDays.value  = wrkDays.value - sickDays.value - rvacDays.value;
		else
			totDays.value  = 15 - sickDays.value - rvacDays.value;

		misAmt.value  = "0.00";

		missDays.focus();
		missDays.select();
		alert("Dias Faltas no puede ser superior a 15 Dias.");
		return false;
	}
	else
	{
		if(wrkDays.value != 0)
			totDays.value  = wrkDays.value - sickDays.value - rvacDays.value;
		else
			totDays.value  = 15 - sickDays.value - rvacDays.value;

		misAmt.value  = "0.00";
	}

	cal_totAmt(row);
}

/*****************************************************
 Function to calculate Extra Hours Amounts
 *****************************************************/
function cal_hrExtAmt(row)
{
	var totHrsAmt = "0.00";

	var salary 		= eval("myForm.salary" + row);
	var aging		= eval("myForm.aging" + row);
	var hours		= eval("myForm.exHR" + row);
	var hrsAmt		= eval("myForm.exHRAmt" + row);

	//var totSalry 	= parseFloat(salary.value) + parseFloat(aging.value);
	var totSalry 	= parseFloat(salary.value);

	totHrsAmt		= (parseFloat(totSalry/120)) * hours.value;
	//REMOVER LA SUMA DEL INTERINATO Y INCLUIR DIAS DE INTERINATO Y HORA EXTRAS INTERINATO

	hrsAmt.value 	= formatCurrency(totHrsAmt);

	cal_totAmt(row);
}

/*****************************************************
Function to calculate Feriado Hours Amounts
*****************************************************/
function cal_ferExtAmt(row)
{
	var totHrsAmt = "0.00";

	var salary 		= eval("myForm.salary" + row);
	var aging		= eval("myForm.aging" + row);
	var ferHR		= eval("myForm.ferHR" + row);
	var ferHRAmt	= eval("myForm.ferHRAmt" + row);

	//var totSalry 	= parseFloat(salary.value) + parseFloat(aging.value);
	var totSalry 	= parseFloat(salary.value);

	totHrsAmt		= (parseFloat(totSalry/120)) * ferHR.value;
	//REMOVER LA SUMA DEL INTERINATO Y INCLUIR DIAS DE INTERINATO Y HORA EXTRAS INTERINATO

	ferHRAmt.value = formatCurrency(totHrsAmt);

	cal_totAmt(row);
}

/*****************************************************
Function to calculate Seventh Hours Amounts
*****************************************************/
function cal_septExtAmt(row)
{
	var totHrsAmt = "0.00";

	var salary 		= eval("myForm.salary" + row);
	var aging		= eval("myForm.aging" + row);
	var septHR		= eval("myForm.septHR" + row);
	var septHRAmt	= eval("myForm.septHRAmt" + row);

	//var totSalry 	= parseFloat(salary.value) + parseFloat(aging.value);
	var totSalry 	= parseFloat(salary.value);

	totHrsAmt		= (parseFloat(totSalry/120)) * septHR.value;
	//REMOVER LA SUMA DEL INTERINATO Y INCLUIR DIAS DE INTERINATO Y HORA EXTRAS INTERINATO

	septHRAmt.value = formatCurrency(totHrsAmt);

	cal_totAmt(row);
}

/*****************************************************
 Function to calculate Vacations Amounts
 *****************************************************/
function cal_vacsAmt(row, type)
{
	var totVacsAmt 	= "0.00";
	var totRVacsAmt = "0.00";

	//VACATIONS ARE GOING TO BE CALCULATED WITH
	var salary 		= eval("myForm.salary" + row);
	var salaryQT	= eval("myForm.salaryQT" + row);
	var salProm		= eval("myForm.salProm" + row);
	var aging		= eval("myForm.aging" + row);
	var vacDays		= eval("myForm.vacDays" + row);
	var rvacDays	= eval("myForm.rvacDays" + row);
	var vacAmt		= eval("myForm.vacAmt" + row);
	var rvacAmt		= eval("myForm.rvacAmt" + row);
	var salType		= eval("myForm.salType" + row);
	var sickDays	= eval("myForm.sickDays" + row);
    var totDays		= eval("myForm.rwrkDays" + row);
	var missDays	= eval("myForm.daysMiss" + row);
	var wrkDays		= eval("myForm.wrkDays" + row);

	var wkDays		= "0";
	var totSalry    = "0.00";
	var wkDaysMiss  = "0";

	//var totSalry 	= parseFloat(salary.value) + parseFloat(aging.value);
	if(salType.value == "V")
		totSalry 	= parseFloat(salProm.value);
	else
		totSalry 	= parseFloat(salary.value);

	if(salType.value == "V" && totSalry == "0.00")
		totSalry 	= parseFloat(salary.value);

	if(type == "N")
	{
		totVacsAmt		= (parseFloat(totSalry/30)) * vacDays.value;
		vacAmt.value 	= formatCurrency(totVacsAmt);
	}
	else if(type == "R")
	{
		if(rvacDays.value >= 0 && rvacDays.value < 16)
		{
			if(wrkDays.value != 0)
				wkDays			= wrkDays.value - rvacDays.value;
			else
				wkDays			= 15 - rvacDays.value;

			if(sickDays.value > 0)
				wkDays = wkDays - sickDays.value;

			if(missDays.value > 0)
				wkDays = wkDays - missDays.value;

			//totDays.value   = 15 - rvacDays.value - sickDays.value - missDays.value - wrkDays.value;
			totDays.value   = wkDays;
			wkDaysMiss		= wkDays + parseFloat(missDays.value);
			//alert(wkDaysMiss);
			//SIN IMPORTAR SI ES VARIABLE O FIJO PARA LO TRABAJADO QUINCENAL VA EN BASE AL BASICO
			//salaryQT.value  = (parseFloat(totSalry/30)) * wkDays;
			salaryQT.value  = formatCurrency((parseFloat(salary.value/30)) * wkDaysMiss);
			totRVacsAmt		= (parseFloat(totSalry/30)) * rvacDays.value;
			rvacAmt.value 	= formatCurrency(totRVacsAmt);
		}
		else if(rvacDays.value > 15)
		{
			if(wrkDays.value != 0)
				totDays.value  = wrkDays.value - sickDays.value - missDays.value;
			else
				totDays.value  = 15 - sickDays.value - missDays.value;

			rvacAmt.value  = "0.00";

			rvacDays.focus();
			rvacDays.select();
			alert("Dias de Vacaciones Descansadas no puede ser superior a 15 Dias.");
			return false;
		}
		else
		{
			if(wrkDays.value != 0)
				totDays.value  = wrkDays.value - sickDays.value - missDays.value;
			else
				totDays.value  = 15 - sickDays.value - missDays.value;

			rvacAmt.value  = "0.00";
		}
	}
	else
	{
		alert("Tipo de Vacaciones no Definido");
		return false;
	}

	cal_totAmt(row);
}

/*****************************************************
 Function to calculate Sick Amounts
 *****************************************************/
function cal_sicksAmt(row)
{
	var totSicksAmt = "0.00";

	var salary 		= eval("myForm.salary" + row);
	var salaryQT	= eval("myForm.salaryQT" + row);
	var salProm		= eval("myForm.salProm" + row);
	var aging		= eval("myForm.aging" + row);
	var sickDays	= eval("myForm.sickDays" + row);
	var sickAmt		= eval("myForm.sickAmt" + row);
    var totDays		= eval("myForm.rwrkDays" + row);
    var rvacDays	= eval("myForm.rvacDays" + row);
	//var totDaysOR	= eval("myForm.wrkDaysOR" + row);
	var salType		= eval("myForm.salType" + row);
	var missDays	= eval("myForm.daysMiss" + row);
	var wrkDays		= eval("myForm.wrkDays" + row);

	//var totSalry 	= parseFloat(salary.value) + parseFloat(aging.value);
	var wkDays		= "0";
	var totSalry 	= "0.00";
	var wkDaysMiss	= "0";

	if(salType.value == "V")
		totSalry 	= parseFloat(salProm.value);
	else
		totSalry 	= parseFloat(salary.value);

	if(salType.value == "V" && totSalry == "0.00")
		totSalry 	= parseFloat(salary.value);

	if(sickDays.value >= 0 && sickDays.value < 16)
	{
		if(wrkDays.value != 0)
			wkDays			= wrkDays.value - sickDays.value;
		else
			wkDays			= 15 - sickDays.value;

		if(rvacDays.value > 0)
			wkDays = wkDays - rvacDays.value;
		if(missDays.value > 0)
			wkDays = wkDays - missDays.value;

		//totDays.value   = 15 - rvacDays.value - sickDays.value - missDays.value - wrkDays.value;
		totDays.value   = wkDays;
		wkDaysMiss		= wkDays + parseFloat(missDays.value);
		//alert(wkDaysMiss);
		//SIN IMPORTAR SI ES VARIABLE O FIJO PARA LO TRABAJADO QUINCENAL VA EN BASE AL BASICO
		//salaryQT.value  = formatCurrency((parseFloat(totSalry.value/30)) * wkDays);
		salaryQT.value  = formatCurrency((parseFloat(salary.value/30)) * wkDaysMiss);
		///PARA APC ESTA FORMULA NO FUNCIONA OBTENER EL PORCENTAJE DEL CONCEPTO SUBSIDIO
		totSicksAmt		= (parseFloat(totSalry/30)) * sickDays.value;
		sickAmt.value 	= formatCurrency(totSicksAmt);
	}
	else if(sickDays.value > 15)
	{
		if(wrkDays.value != 0)
			totDays.value  = wrkDays.value - rvacDays.value - missDays.value;
		else
			totDays.value  = 15 - rvacDays.value - missDays.value;

		sickAmt.value  = "0.00";

		sickDays.focus();
		sickDays.select();
		alert("Dias de Subsidios no puede ser superior a 15 Dias.");
		return false;
	}
	else
	{
		if(wrkDays.value != 0)
			totDays.value  = wrkDays.value - rvacDays.value - missDays.value;
		else
			totDays.value  = 15 - rvacDays.value - missDays.value;

		sickAmt.value  = "0.00";
	}
	cal_totAmt(row);
}

/*****************************************************
 Function to calculate Total Amounts
 *****************************************************/
function cal_totAmt(row)
{
	var total 			= eval("myForm.totalAmt" + row);
	var totIncome		= eval("myForm.ttIncome" + row);
	var totDeduction	= eval("myForm.totDed" + row);
	var finalAmt		= eval("myForm.finAmtTT" + row);
	var decemberAmt		= eval("myForm.decAmtTT" + row);
	var salaryQT		= eval("myForm.salaryQT" + row);
	var agingQT			= eval("myForm.agingQT" + row);
	var exHRAmt			= eval("myForm.exHRAmt" + row);
	var ferHRAmt		= eval("myForm.ferHRAmt" + row);
	var septHRAmt		= eval("myForm.septHRAmt" + row);
	var vacations		= eval("myForm.vacAmt" + row);
	var restVacations	= eval("myForm.rvacAmt" + row);
	var sickness		= eval("myForm.sickAmt" + row);
	var inssLabor		= eval("myForm.inssLB" + row);
	var IR				= eval("myForm.ir" + row);
	var inssPatronal	= eval("myForm.inssPT" + row);
	var inatecTP		= eval("myForm.inatec" + row);
	var ttNet			= eval("myForm.totNet" + row);
	var trstAmt			= eval("myForm.trustAmt" + row);
	var viaticAmt		= eval("myForm.viatAmt" + row);
	var totNGIncome		= eval("myForm.totNGIncome" + row);

	var dayMissAmt		= eval("myForm.amountMiss" + row);
	var debitSum 		= 0.0;
	var creditSum 		= 0.0;

	for (i=0; i < 10; i++)
    {
   		//OTHER INCOMES
		debitSum = (debitSum) + 1*(eval("myForm.amountINC" + i + ".value"));

		//DEDUCTION
		creditSum = (creditSum) + 1*(eval("myForm.amountDED" + i + ".value"));

    }

	var salaryQT   = (parseFloat(salaryQT.value) + parseFloat(agingQT.value) + parseFloat(exHRAmt.value) + parseFloat(ferHRAmt.value) + parseFloat(septHRAmt.value) + parseFloat(vacations.value) + parseFloat(restVacations.value) + parseFloat(sickness.value));
	var dedSal     = (parseFloat(dayMissAmt.value));
	var incGRV	   = parseFloat(salaryQT) - parseFloat(dedSal) - parseFloat(sickness.value) + parseFloat(debitSum);
	var incGRV2	   = parseFloat(salaryQT) - parseFloat(dedSal) - parseFloat(sickness.value) + parseFloat(debitSum);

	//INGRESOS GRAVABLES
	total.value 	  = formatCurrency(parseFloat(salaryQT) - parseFloat(sickness.value) - parseFloat(dedSal) + parseFloat(debitSum));
	//INGRESOS NO GRAVABLES
	totNGIncome.value	  = formatCurrency(parseFloat(finalAmt.value) + parseFloat(decemberAmt.value) + parseFloat(trstAmt.value) + parseFloat(sickness.value) + parseFloat(viaticAmt.value));
	//TOTAL INGRESOS
    totIncome.value   = formatCurrency(parseFloat(salaryQT) - parseFloat(dedSal) + parseFloat(finalAmt.value) + parseFloat(decemberAmt.value) + parseFloat(debitSum) + parseFloat(trstAmt.value) + parseFloat(viaticAmt.value));
    //TOTAL DEDUCCIONES
    totDeduction.value= formatCurrency(parseFloat((incGRV * 6.25)/100) + parseFloat(creditSum) + parseFloat(IR.value));

    
    //if(parseFloat(incGRV) > 72410)
    //	incGRV = "72410";
    //ENERO 2017
    if(parseFloat(incGRV) > 82953.88)
    	incGRV = "82953.88";
    
	//alert(incGRV);
	inssLabor.value		= formatCurrency(parseFloat((incGRV * 6.25)/100));
	//inssPatronal.value	= formatCurrency(parseFloat((incGRV * 18.5)/100));
	//ENERO 2017
	inssPatronal.value	= formatCurrency(parseFloat((incGRV * 19)/100));
	inatecTP.value		= formatCurrency(parseFloat((incGRV2 * 2)/100));
	ttNet.value			= formatCurrency(parseFloat(salaryQT) - parseFloat(dedSal) + parseFloat(finalAmt.value) + parseFloat(decemberAmt.value) + parseFloat(viaticAmt.value) + parseFloat(trstAmt.value) + parseFloat(debitSum) - parseFloat((incGRV * 6.25)/100) - parseFloat(creditSum) - parseFloat(IR.value));
}
