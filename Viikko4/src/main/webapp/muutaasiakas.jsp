<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
</head>
<body>
<form id="tiedot">
<table>
<thead>
<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>
<tr>
<th>Etunimi</th>
<th>Sukunimi</th>
<th>Puhelin</th>
<th>Sposti</th>
<th></th>
</tr>
</thead>
<tbody>
<tr> 
<td> <input type="text" name="Etunimi" id="Etunimi"> </td>
<td> <input type="text" name="Sukunimi" id="Sukunimi"> </td>
<td> <input type="text" name="Puhelin" id="Puhelin"> </td>
<td> <input type="text" name="Sposti" id="Sposti"> </td>
<td> <input type="submit" id="tallenna" value="Hyv?ksy"> </td>
</tr>
</tbody>

</table>
<input type="hidden" name="asiakas_id" id="asiakas_id">
</form>
<span id="ilmo"> </span>

</body>
<script>
$(document).ready(function(){
$("#takaisin").click(function(){
document.location="ListaaAsiakkaat.jsp";
});

var asiakas_id = requestURLParam("asiakas_id");
$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){
$("#asiakas_id").val(result.asiakas_id);	
$("#Etunimi").val(result.etunimi);
$("#Sukunimi").val(result.sukunimi);
$("#Puhelin").val(result.puhelin);
$("#Sposti").val(result.sposti);
}});

$("#tiedot").validate({
	rules:{
		Etunimi: {
			required: true,
			minlength: 3
		},
		Sukunimi: {
			required: true,
			minlength: 3
		},
		Puhelin: {
			required: true,
			minlength: 10,
			number: true
		},
		Sposti: {
			required: true,
			minlength: 4
		}
	},
	
	messages: {
		Etunimi:{
		required: "Puuttuu",
		minlength: "Liian lyhyt"
	},
	Sukunimi:{ 
	required: "Puuttuu",
	minlength: "Liian lyhyt"
	},
	Puhelin:{ 
	required:"Puuttuu",
	minlength: "Liian lyhyt",
	number: "Ei ole numero"
	},
	Sposti:{ 
	required:"Puuttuu",
	minlength: "Liian lyhyt"
}
},
submitHandler: function(form){
paivitaTiedot();
}
});
});

function paivitaTiedot(){
var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result){
if(result.response==0){
	$("#ilmo").html("Asiakkaan p?ivitt?minen ep?onnistui.")
}else if(result.response==1){
	$("#ilmo").html("Asiakkaan p?ivitt?minen onnistui.")
	$("#Etunimi", "#Sukunimi", "#Puhelin", "#Sposti").val("");
}
}});
}


</script>

</html>