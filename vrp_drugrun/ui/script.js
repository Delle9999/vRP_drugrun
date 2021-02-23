window.addEventListener('message', function(event) {
	var item = event.data;

	if (item.status == true){
		$("#container").show();
	}
	else if (item.status == false){
    $("#container").fadeOut();
	}

});

function Luk(){
	$("#container").fadeOut();
	$.post("http://vrp_drugrun/Luk");
}

/* Prim farver */

function farve1(){
	$.post("http://vrp_drugrun/farve1");
}

function farve2(){
	$.post("http://vrp_drugrun/farve2");
}

function farve3(){
	$.post("http://vrp_drugrun/farve3");
}

function farve4(){
	$.post("http://vrp_drugrun/farve4");
}

function farve5(){
	$.post("http://vrp_drugrun/farve5");
}

function farve6(){
	$.post("http://vrp_drugrun/farve6");
}

function farve7(){
	$.post("http://vrp_drugrun/farve7");
}

function farve8(){
	$.post("http://vrp_drugrun/farve8");
}

function farve9(){
	$.post("http://vrp_drugrun/farve9");
}

function farve10(){
	$.post("http://vrp_drugrun/farve10");
}