<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style>
th {
background-color: green;
color: pink;}

tbody{
background-color: pink; }

.oikealle{
text-align: right;}

</style>
<title>Asiakkaiden haku</title>
</head>
<body>


<table id="listaus">
<thead>
<tr> 
<th colspan="5" class="oikealle"> <span id="uusiAsiakas">Lis?? uusi asiakas</span></th>
</tr>
<tr> 
<th class="oikealle">  Hakusana:  </th>  
<th colspan="3"> <input type="text" id="hakusana"></th> 
<th> <input type="button" value="hae" id="hakunappi"></th>
</tr>
<tr>
<th>Etunimi</th>
<th>Sukunimi</th>
<th>Puhelin</th>
<th>Sposti</th>
<th> </th>
</tr>
</thead>
<tbody>
</tbody>
</table>
<script>
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaAsiakas.jsp";
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		if(event.which==13){
			haeAsiakkaat();
		}
	});
		$("#hakusana").focus();
});

function haeAsiakkaat (){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){
		$.each(result.asiakkaat, function(i, field){
			var htmlStr;
			htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>";
			htmlStr+="<td>" +field.etunimi+"</td>";
			htmlStr+="<td>" +field.sukunimi+"</td>";
			htmlStr+="<td>" +field.puhelin+"</td>";
			htmlStr+="<td>" +field.sposti+"</td>";
			htmlStr+="<td> <a href='muutaasiakas.jsp?asiakas_id="+field.asiakas_id+"'>Muuta</a>&nbsp";
			htmlStr+="<span class='poista' onclick=poista('"+field.sukunimi+"')>Poista</span></td>";
			htmlStr+="</tr>";
			$("#listaus tbody").append(htmlStr);
			
		});
		}});
}

function poista(sukunimi){
	if(confirm("Poista asiakas " + sukunimi + "?")){
		$.ajax({url:"asiakkaat/"+sukunimi, type:"DELETE", dataType:"json", success:function(result){
			if(result.response==0){
				$("ilmo").html("Asiakkaan poisto ep?onnistui.");
			}else if(result.response==1){
				$("#rivi_"+sukunimi).css("background-color", "red");
				alert("Asiakkaan " + sukunimi + " poisto onnistui.");
				haeAsiakkaat();
				}
			}});
	}
}

</script>
</body>
</html>