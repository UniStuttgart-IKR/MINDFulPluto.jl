function insert_bootstrap()
	return @htl("""
	<!--html-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
		  integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

	<!-- <link rel="stylesheet" href="hide-ui.css"> -->

	<script>

	</script>

	<!--!html-->
	""")
end

function resize_cells()
	# 2 cells per line with javascript html
	return html"""
	<!--html-->

	<script>
	//find body
	var body = document.querySelector("body");
	//set overflow hidden
	body.style.overflow = "hidden";
	

	//find <main>
	var main = document.querySelector("main");

	//set main style to max-width 100%
	main.style.maxWidth = "100%";
	//set main color to darkslategray

	//find rich-output class and remove backgroundColor
	document.querySelectorAll(".rich_output").forEach((cell, i) => {
		cell.style.background = "transparent";
	});

	//remove header
	document.querySelector("header").style.display = "none";

	//remove footer
	document.querySelector("footer").style.display = "none";


	//place first cell ath the top and 2nd cell at the bottom
	document.querySelectorAll(".code_folded ").forEach((cell, i) => {
		if (i==0) {
			cell.style.display = "none";
		}
		else if (i==1) {
			cell.style.position = "absolute";
			cell.style.top = "0";
			cell.style.left = "0";
			cell.style.width = "100%";
			cell.style.margin = "0";
		} else if (i==2 || i==3 || i==4){
			//align these 3 cells horizontally
			//cell.style.display = "inline-block";
			//cell.style.verticalAlign = "top";
			//cell.style.bottom = "0px";
			//cell.style.width = "33%";
			//cell.style.margin = "0.5%";
			//cell.style.position = "absolute";
			//cell.style.right = (i-2)*33.33 + "%";

		}
	});



	//align cells horizontally
	document.querySelectorAll(".code_folded ").forEach((cell, i) => {
		//if (i==0) {
		//    cell.style.display = "none";
		//} else {

		//cell.style.display = "inline-block";
		//cell.style.verticalAlign = "top";
		//cell.style.width = "32%";
		//cell.style.margin = "0.5%";

		//center it
		//cell.style.textAlign = "center";

		//add description under cell
		//var description = document.createElement("div");
		//description.innerHTML =  "hello world";
		//cell.appendChild(description);
		
		//place last two cells at bottom of screen
		//if (i==document.querySelectorAll(".code_folded ").length-1) {
		//    cell.style.position = "absolute";
		//    cell.style.bottom = "0";
		//    cell.style.left = "0";
		//    cell.style.width = "100%";
		//    cell.style.margin = "0";
		//
		//    }
		//}
		
	});

	//hide shown cells
	document.querySelectorAll(".show_input").forEach((cell, i) => {
		cell.style.display = "none";
	});

	//hide div with class="helpbox-true hidden "
	document.querySelectorAll(".helpbox-true.hidden").forEach((cell, i) => {
		cell.style.display = "none";
	}); 

	//find title=Drag to move cell
	document.querySelectorAll("pluto-shoulder").forEach((cell, i) => {
		cell.style.display = "none";
		cell.style.width = "0px";
	});

	//find selector: #a5e47ed8-f062-49bf-a1f6-9cedefed221a > pluto-shoulder
	//document.querySelector("#a5e47ed8-f062-49bf-a1f6-9cedefed221a > .pluto-shoulder").style.width = "0px";
		
	console.log( document.getElementsByTagName("pluto-logs-container"));

	//find all types pluto-logs-container and set display to none
	//document.getElementsByTagName("pluto-logs-container").forEach((cell, i) => {
	//    cell.style.display = "none";
	//});

	//find tag main and set class to container-fluid
	document.getElementsByTagName("main")[0].className = "container";
	//document.getElementsByTagName("main")[0].style += " padding-bottom: 0px;";
	

	//find tag pluto-notebook and set class to row
	document.getElementsByTagName("pluto-notebook")[0].className = "row";
	document.getElementsByTagName("pluto-notebook")[0].style = "width: 100vw;";
	document.getElementsByTagName("pluto-notebook")[0].style = "background: rgba(0,0,0,0) !important;";
	document.getElementsByTagName("pluto-notebook")[0].style = "margin-top: 30vh; margin-left:10vw; margin-right:10vw;";

	//find shown cells and set class to col except for the first one
	document.querySelectorAll(".code_folded").forEach((cell, i) => {
		if (i>1) {
			cell.className += "col";
		} else {
			
		}
	});

	
	//show all cards 
	document.querySelectorAll('.card').forEach((card, i) => {
		card.style.display = 'block';
	});

	//hide last 2 cells 
	var cells = document.querySelectorAll('.show_input ');
	cells = Array.prototype.slice.call(cells, -2);
	cells.forEach((cell, i) => {
		cell.style.display = 'none';
	});

	document.querySelectorAll('.code_folded').forEach((card, i) => {
			//if col in className of card 
			if (card.className.includes('col')) {
				card.style.display = 'none';
			}
	});


	cells = document.querySelectorAll('.code_folded ');
	cells = Array.prototype.slice.call(cells, -2);

	cells.forEach((cell, i) => {
		cell.querySelector('.cm-editor').style.background = 'transparent';

		cell.style.display = 'inline-block';
		cell.style.verticalAlign = 'top';
		cell.style.width = '30vw';
		cell.style.maxWidth = '30vw';
		cell.style.height = '50vh';
		cell.style.margin = '2.5%';
		cell.style.textAlign = 'start';

		cell.style.background = 'rgba(217, 147, 232, 0.1)';
		cell.style.borderRadius = '16px';
		cell.style.boxShadow = '0 4px 30px rgba(0, 0, 0, 0.1)';

		cell.style.padding = '20px 20px 20px 20px';

		//find element pluto-trafficlight
		cell.querySelector('pluto-trafficlight').style.display = 'none';

		var log_container = cell.querySelector('pluto-logs-container');
		if (log_container != null) {
			log_container.style.display = 'transparent';
		}

		//remove pluto-log-icon
		var log_icon = cell.querySelector('pluto-log-icon');
		if (log_icon != null) {
			log_icon.style.display = 'none';
		}

		//find class=Stdout and change style 
		var stdout = cell.querySelector('pluto-log-dot')
		if (stdout != null) {
			stdout.style.background = 'transparent';
			stdout.style.border = '2px solid #FFFFFF';
		}
		
		var rich_output = cell.querySelector('pluto-output');
		if (rich_output != null) {
			rich_output.style.borderRadius = '16px';
			rich_output.style.background = 'black';
		}
		

	});

	var p_nb = document.getElementsByTagName('pluto-notebook')[0];
	p_nb.style.marginTop = '31vh';
	p_nb.style.marginLeft = '20vw';
	p_nb.style.marginRight = '-25vw';
	p_nb.style.backgroundColor = 'transparent';



	</script>

	<!--!html-->
	"""
end

function update_width_devving()
	return @htl("""
	<!--html-->

	<script>
	document.querySelectorAll(".rich_output").forEach((cell, i) => {
		cell.style.overflowX = "visible";
	});
	</script>

	<!--!html-->
	""")
end

function update_domain_list(topology)

	domain_names = 1:get_ibn_size(topology)[1]

	return @htl("""
	<!--html-->

	<script>
		console.log($(domain_names));

		//find domain list
		var domain_lists = document.querySelectorAll(".domain_selection_select");

		//for each domain list
		domain_lists.forEach((domain_list, j) => {
			//find out which option was selected in domain_list
			var selected_value = domain_list.value;
			

			//clear domain list except first option
			while (domain_list.options.length > 1) {
				domain_list.remove(1);
			}
			

			//add domains to domain list

			$(domain_names).forEach((domain, i) => {
				var option = document.createElement("option");
				option.value = domain;
				option.innerHTML = domain;
				//check if domain was selected
				if (selected_value != undefined) {
					if (selected_value == domain) {
						option.selected = true;
					}
				}

				domain_list.appendChild(option);

			});
		});

		//reset domain list to first option
		domain_lists.forEach((domain_list, j) => {
			domain_list.value = domain_list.options[0].value;
		});

		
		add_toast_to_div('MINDFulPluto.jl', 'Topology loaded.')

		
	</script>
	<!--!html-->
	""")

end

function update_node_list(topology, domain, node_number)

	nodes = get_nodes_of_subdomain(topology, domain)

	return @htl("""
	<!--html-->

	<script>
		console.log($(nodes));

		//find node list
		var node_list = document.querySelector(".node_selection_select_$(node_number)");

		
		//find out which option was selected in node_list
		var selected_value = node_list.value;
		

		//clear node list except first option
		while (node_list.options.length > 1) {
			node_list.remove(1);
		}
		

		//add nodes to node list

		$(nodes).forEach((node, i) => {
			var option = document.createElement("option");
			option.value = node;
			option.innerHTML = node;
			//check if node was selected
			if (selected_value != undefined) {
				if (selected_value == node) {
					option.selected = true;
				}
			}

			node_list.appendChild(option);

		});

		</script>
	<!--!html-->
	""")

end


function update_intent_list_html()
	intent_names = [x["name"] for x in intent_list]
	intent_configs = [string(x["n1_sn"]) * "." * string(x["n1"]) * " -> " * string(x["n2_sn"]) * "." * string(x["n2"]) for x in intent_list]
	intent_toplogies = [x["topology"] for x in intent_list]



	return @htl("""
	<!--html-->
	<script>
		let intent_names = $(intent_names);
		let intent_configs = $(intent_configs);
		let intent_toplogies = $(intent_toplogies);

		console.log(intent_names);


		let intent_table = document.querySelector(".table > tbody");

		//clear all <tr> except first one
		while (intent_table.childElementCount > 0) {
			intent_table.removeChild(intent_table.lastChild);
		}

		//add new <tr> for each intent
		intent_names.forEach((intent_name, index) => {
			let new_row = document.createElement("tr");
			new_row.innerHTML = `
				<th scope="row">\${index + 1}</th>
				<td>\${intent_name}</td>
				<td>\${intent_toplogies[index]}</td>
				<td>\${intent_configs[index]}</td>
				<td>state</td>
			`;
			intent_table.appendChild(new_row);
		});

	</script>
	<!--!html-->
	""")
end
