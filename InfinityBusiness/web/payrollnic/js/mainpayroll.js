/*****************************************************
 Function to open popup window, only used in header page
 *****************************************************/
function creatBy_search(form, code, contextRoot)
{
		openEntDialog("EMP", "A", "myForm", "creatById", "creatByNm", contextRoot);	
}

/*****************************************************
 Function to open popup window, only used in header page
 *****************************************************/
function checkBy_search(form, code, contextRoot)
{
		openEntDialog("EMP", "A", "myForm", "checkById", "checkByNm", contextRoot);	
}

/*****************************************************
 Function to open popup window, only used in header page
 *****************************************************/
function autBy_search(form, code, contextRoot)
{
		openEntDialog("EMP", "A", "myForm", "autById", "autByNm", contextRoot);	
}
 
 /*****************************************************
 Function to open popup window, only used in header page
 *****************************************************/
function payBy_search(form, code, contextRoot)
{
		openEntDialog("EMP", "A", "myForm", "payById", "payByNm", contextRoot);	
}

/********************************************
 * check if page changed before go to next page
 ********************************************/
function prodrev_link_chg(link)
{
	window.location=link;
}

/*****************************************************
Function to open popup window, only used in header page
*****************************************************/
function employee_search(form, code, contextRoot, row)
{
		openEntDialog("EMP", "A", "myForm", "checkById" + row, "checkByNm" + row, contextRoot);	
}

/*****************************************************
Function to calculate HP,ORD,EX,TOTAL
*****************************************************/
function cal_days(row, type)
{
	//VACATIONS ARE GOING TO BE CALCULATED WITH 
	var day1 		= eval("myForm.day1Hrs" + row);
	var day2		= eval("myForm.day2Hrs" + row);	
	var day3		= eval("myForm.day3Hrs" + row);
	var day4		= eval("myForm.day4Hrs" + row);
	var day5		= eval("myForm.day5Hrs" + row);
	var day6		= eval("myForm.day6Hrs" + row);
	var day7		= eval("myForm.day7Hrs" + row);
	var day8		= eval("myForm.day8Hrs" + row);
	var day9		= eval("myForm.day9Hrs" + row);
	var day10		= eval("myForm.day10Hrs" + row);
	var day11		= eval("myForm.day11Hrs" + row);
    var day12		= eval("myForm.day12Hrs" + row);
	var day13		= eval("myForm.day13Hrs" + row);    
	var day14		= eval("myForm.day14Hrs" + row);
	var day15		= eval("myForm.day15Hrs" + row);
	
	var hp			= eval("myForm.hp" + row);
	var ord			= eval("myForm.ord" + row);
	var ext			= eval("myForm.ext" + row);
	var total		= eval("myForm.total" + row);

	var emplSALQ	= eval("myForm.emplSalQ" + row);
	var ordAMT		= eval("myForm.ordAMT" + row);
	var extAMT		= eval("myForm.extAMT" + row);

	
	var tDays		= myForm.days.value;
	var cOrd		= 104;
	var totDays		= 0;
	
	var day16 		= 0;
	if(parseInt(tDays) == 16)
	{	
		day16 = eval("myForm.day16Hrs" + row);
		
		cOrd	= 112;	
	    totDays = parseInt(day1.value) +  parseInt(day2.value) +  parseInt(day3.value) +  parseInt(day4.value) +  parseInt(day5.value) +  parseInt(day6.value) +  parseInt(day7.value) +  parseInt(day8.value) +  parseInt(day9.value) +  parseInt(day10.value) +  parseInt(day11.value) +  parseInt(day12.value) +  parseInt(day13.value) +  parseInt(day14.value)  +  parseInt(day15.value) +  parseInt(day16.value);
	}
	else
	{
		totDays = parseInt(day1.value) +  parseInt(day2.value) +  parseInt(day3.value) +  parseInt(day4.value) +  parseInt(day5.value) +  parseInt(day6.value) +  parseInt(day7.value) +  parseInt(day8.value) +  parseInt(day9.value) +  parseInt(day10.value) +  parseInt(day11.value) +  parseInt(day12.value) +  parseInt(day13.value) +  parseInt(day14.value)  +  parseInt(day15.value);
	}
	if(parseInt(totDays) > parseInt(cOrd))
	{	
		ord.value 	= parseInt(cOrd);
		ext.value 	= parseInt(totDays) - parseInt(cOrd);
		
		//alert(parseFloat(emplSALQ.value));
		
		//ordAMT.value	= formatCurrency(parseInt(cOrd) * parseFloat(emplSALQ.value));
		//extAMT.value	= formatCurrency(parseInt(totDays - cOrd) * parseFloat(emplSALQ.value));
		ordAMT.value	= formatCurrency(parseFloat(emplSALQ.value * 120));
		extAMT.value	= formatCurrency(parseInt(totDays - cOrd) * parseFloat(emplSALQ.value * 2));
	}
	else
	{	
		ord.value 		= parseInt(totDays);
		ext.value 		= 0;
		ordAMT.value	= formatCurrency(parseInt(totDays) * parseFloat(emplSALQ.value));
		extAMT.value	= 0;
	}
	
	hp.value 		= parseInt(totDays);
	total.value 	= parseInt(totDays);	
	
	var day1Total	= 0.0;
	var day2Total	= 0.0;
	var day3Total	= 0.0;
	var day4Total	= 0.0;
	var day5Total	= 0.0;
	var day6Total	= 0.0;
	var day7Total	= 0.0;
	var day8Total	= 0.0;
	var day9Total	= 0.0;
	var day10Total	= 0.0;
	var day11Total	= 0.0;
	var day12Total	= 0.0;
	var day13Total	= 0.0;
	var day14Total	= 0.0;
	var day15Total	= 0.0;
	var day16Total	= 0.0;
	
	var hpTotal		= 0.0;
	var ordTotal	= 0.0;
	var extTotal	= 0.0;
	var totalGRAND	= 0.0;
	var ordAMTTotal	= 0.0;
	var extAMTTotal	= 0.0;
	
    for(var i = 0; i < myForm.rows.value; i++)
    {
    	day1Total =  parseFloat((day1Total) + 1*(eval("myForm.day1Hrs" + i + ".value")));
    	day2Total =  parseFloat((day2Total) + 1*(eval("myForm.day2Hrs" + i + ".value")));
    	day3Total =  parseFloat((day3Total) + 1*(eval("myForm.day3Hrs" + i + ".value")));
    	day4Total =  parseFloat((day4Total) + 1*(eval("myForm.day4Hrs" + i + ".value")));
    	day5Total =  parseFloat((day5Total) + 1*(eval("myForm.day5Hrs" + i + ".value")));
    	day6Total =  parseFloat((day6Total) + 1*(eval("myForm.day6Hrs" + i + ".value")));
    	day7Total =  parseFloat((day7Total) + 1*(eval("myForm.day7Hrs" + i + ".value")));
    	day8Total =  parseFloat((day8Total) + 1*(eval("myForm.day8Hrs" + i + ".value")));
    	day9Total =  parseFloat((day9Total) + 1*(eval("myForm.day9Hrs" + i + ".value")));
    	day10Total =  parseFloat((day10Total) + 1*(eval("myForm.day10Hrs" + i + ".value")));
    	day11Total =  parseFloat((day11Total) + 1*(eval("myForm.day11Hrs" + i + ".value")));
    	day12Total =  parseFloat((day12Total) + 1*(eval("myForm.day12Hrs" + i + ".value")));
    	day13Total =  parseFloat((day13Total) + 1*(eval("myForm.day13Hrs" + i + ".value")));
    	day14Total =  parseFloat((day14Total) + 1*(eval("myForm.day14Hrs" + i + ".value")));
    	day15Total =  parseFloat((day15Total) + 1*(eval("myForm.day15Hrs" + i + ".value")));
   	
    	if(parseInt(tDays) == 16)
    	{	
        	day16Total = (day16Total) + 1*(eval("myForm.day16Hrs" + i + ".value"));

    	} 	

    	hpTotal		= (hpTotal) + 1*(eval("myForm.hp" + i + ".value"));
    	ordTotal	= (ordTotal) + 1*(eval("myForm.ord" + i + ".value"));
    	extTotal	= (extTotal) + 1*(eval("myForm.ext" + i + ".value"));
    	totalGRAND	= (totalGRAND) + 1*(eval("myForm.total" + i + ".value"));
    	ordAMTTotal	= (ordAMTTotal) + 1*(eval("myForm.ordAMT" + i + ".value"));
    	extAMTTotal	= (extAMTTotal) + 1*(eval("myForm.extAMT" + i + ".value"));
    }
    
    myForm.day1Total.value  = formatQty(day1Total);
    myForm.day2Total.value  = formatQty(day2Total);
    myForm.day3Total.value  = formatQty(day3Total);
    myForm.day4Total.value  = formatQty(day4Total);
    myForm.day5Total.value  = formatQty(day5Total);
    myForm.day6Total.value  = formatQty(day6Total);
    myForm.day7Total.value  = formatQty(day7Total);
    myForm.day8Total.value  = formatQty(day8Total);
    myForm.day9Total.value  = formatQty(day9Total);
    myForm.day10Total.value = formatQty(day10Total);
    myForm.day11Total.value = formatQty(day11Total);
    myForm.day12Total.value = formatQty(day12Total);
    myForm.day13Total.value = formatQty(day13Total);
    myForm.day14Total.value = formatQty(day14Total);
    myForm.day15Total.value = formatQty(day15Total);

	if(parseInt(tDays) == 16)
	{	
    	myForm.day16Total.value = formatQty(day16Total);

	}
	
	myForm.hpTotal.value 		= formatQty(hpTotal);
	myForm.ordTotal.value		= formatQty(ordTotal);
	myForm.extTotal.value 		= formatQty(extTotal);
	myForm.totalGRAND.value		= formatQty(totalGRAND);
	myForm.ordAMTTotal.value 	= formatCurrency(ordAMTTotal);
	myForm.extAMTTotal.value 	= formatCurrency(extAMTTotal);
}

/*****************************************************
Function to calculate HP,ORD,EX,TOTAL
*****************************************************/
function cal_total_days()
{	
	var day1Total	= 0.0;
	var day2Total	= 0.0;
	var day3Total	= 0.0;
	var day4Total	= 0.0;
	var day5Total	= 0.0;
	var day6Total	= 0.0;
	var day7Total	= 0.0;
	var day8Total	= 0.0;
	var day9Total	= 0.0;
	var day10Total	= 0.0;
	var day11Total	= 0.0;
	var day12Total	= 0.0;
	var day13Total	= 0.0;
	var day14Total	= 0.0;
	var day15Total	= 0.0;
	var day16Total	= 0.0;
	
	var hpTotal		= 0.0;
	var ordTotal	= 0.0;
	var extTotal	= 0.0;
	var totalGRAND	= 0.0;
	var ordAMTTotal	= 0.0;
	var extAMTTotal	= 0.0;
	
	var tDays		= myForm.days.value;

    for(var i = 0; i < parseInt(myForm.rows.value); i++)
    {
    	//alert(eval("myForm.day1Hrs" + i + ".value"));
    	
    	day1Total = parseFloat((day1Total) + 1*(eval("myForm.day1Hrs" + i + ".value")));
    	day2Total = parseFloat((day2Total) + 1*(eval("myForm.day2Hrs" + i + ".value")));
    	day3Total = parseFloat((day3Total) + 1*(eval("myForm.day3Hrs" + i + ".value")));
    	day4Total = parseFloat((day4Total) + 1*(eval("myForm.day4Hrs" + i + ".value")));
    	day5Total = parseFloat((day5Total) + 1*(eval("myForm.day5Hrs" + i + ".value")));
    	day6Total = parseFloat((day6Total) + 1*(eval("myForm.day6Hrs" + i + ".value")));
    	day7Total = parseFloat((day7Total) + 1*(eval("myForm.day7Hrs" + i + ".value")));
    	day8Total = parseFloat((day8Total) + 1*(eval("myForm.day8Hrs" + i + ".value")));
    	day9Total = parseFloat((day9Total) + 1*(eval("myForm.day9Hrs" + i + ".value")));
    	day10Total = parseFloat((day10Total) + 1*(eval("myForm.day10Hrs" + i + ".value")));
    	day11Total = parseFloat((day11Total) + 1*(eval("myForm.day11Hrs" + i + ".value")));
    	day12Total = parseFloat((day12Total) + 1*(eval("myForm.day12Hrs" + i + ".value")));
    	day13Total = parseFloat((day13Total) + 1*(eval("myForm.day13Hrs" + i + ".value")));
    	day14Total = parseFloat((day14Total) + 1*(eval("myForm.day14Hrs" + i + ".value")));
    	day15Total = parseFloat((day15Total) + 1*(eval("myForm.day15Hrs" + i + ".value")));

    	if(parseInt(tDays) == 16)
    	{	
        	day16Total = parseFloat((day16Total) + 1*(eval("myForm.day16Hrs" + i + ".value")));
    	} 	

    	hpTotal		= (hpTotal) + 1*(eval("myForm.hp" + i + ".value"));
    	ordTotal	= (ordTotal) + 1*(eval("myForm.ord" + i + ".value"));
    	extTotal	= (extTotal) + 1*(eval("myForm.ext" + i + ".value"));
    	totalGRAND	= (totalGRAND) + 1*(eval("myForm.total" + i + ".value"));
    	ordAMTTotal	= (ordAMTTotal) + 1*(eval("myForm.ordAMT" + i + ".value"));
    	extAMTTotal	= (extAMTTotal) + 1*(eval("myForm.extAMT" + i + ".value"));

    }
    
    myForm.day1Total.value  = formatQty(day1Total);
    myForm.day2Total.value  = formatQty(day2Total);
    myForm.day3Total.value  = formatQty(day3Total);
    myForm.day4Total.value  = formatQty(day4Total);
    myForm.day5Total.value  = formatQty(day5Total);
    myForm.day6Total.value  = formatQty(day6Total);
    myForm.day7Total.value  = formatQty(day7Total);
    myForm.day8Total.value  = formatQty(day8Total);
    myForm.day9Total.value  = formatQty(day9Total);
    myForm.day10Total.value = formatQty(day10Total);
    myForm.day11Total.value = formatQty(day11Total);
    myForm.day12Total.value = formatQty(day12Total);
    myForm.day13Total.value = formatQty(day13Total);
    myForm.day14Total.value = formatQty(day14Total);
    myForm.day15Total.value = formatQty(day15Total);
    
	if(parseInt(tDays) == 16)
	{	
    	myForm.day16Total.value = formatQty(day16Total);

	}
	
	myForm.hpTotal.value 		= formatQty(hpTotal);
	myForm.ordTotal.value		= formatQty(ordTotal);
	myForm.extTotal.value 		= formatQty(extTotal);
	myForm.totalGRAND.value		= formatQty(totalGRAND);
	myForm.ordAMTTotal.value 	= formatCurrency(ordAMTTotal);
	myForm.extAMTTotal.value 	= formatCurrency(extAMTTotal);
}

/*****************************************************
Function to open popup window for entity search
*****************************************************/
function employee_search(f_name, value_a, label_a, payrollId, contextPath, value_b)
{
	 openSEmployeesDialog(f_name, value_a, label_a, payrollId, contextPath, value_b);	
}
