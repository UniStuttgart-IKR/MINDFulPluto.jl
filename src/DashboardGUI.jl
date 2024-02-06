function get_dashboard_main_div()

	html_div = @htl("""
  <!--html-->
		<body>
		<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11" id="toast_container">

		</div>


		<div class="d-flex align-items-center justify-content-center">
			<div class=" d-flex main-card">
				<div class="left-wrapper">
					<div class="top-desc d-flex align-items-center">
						<span class="container-fluid title-span justify-content-center align-items-center input-group-text no-border">
							MINDFulPlutoGUI v0.1.1
						</span>
					</div>

					<div class="menu-bar">
						<div class="container">
							<div class="row menu-buttons">
								<button class="btn btn-outline-light btn-lg create-intent text-nowrap" onclick="changeViewDisplay(`visualisation`, true)">
									Visualisation
								</button>
							</div>

							<div class="row menu-buttons">
								<button class="btn btn-outline-light btn-lg create-intent text-nowrap" onclick="changeViewDisplay(`intenttable`, true)">
									Intent list
								</button>
							</div>

							<div class="row menu-buttons">
								<button class="btn btn-outline-light btn-lg create-intent text-nowrap" onclick="changeViewDisplay(`devmode`, true)">
									Developer Mode
								</button>
							</div>
							
							<div class="row menu-buttons settings">
								<button class="btn btn-outline-light btn-lg create-intent text-nowrap">
									Dashboard settings
								</button>
							</div>
						</div>
					</div>
				</div>

				<div class="container-fluid content">
					<div class='container-fluid table-container' style='display:none;'>
						<table class='table table-borderless align-middle'>
							<thead>
								<tr>
									<th scope='col'>#</th>
									<th scope='col'>Name</th>
									<th scope='col'>Topology</th>
									<th scope='col'>Config</th>
									<th scope='col'>State</th>
									<th scope='col'>Actions</th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<th scope='row'>1</th>
									<td>Intent 1</td>
									<td>4nets</td>
									<td>1.1 -> 2.1</td>
									<td>installed</td>
								</tr>

								<tr>
									<th scope='row'>2</th>
									<td>Intent 2</td>
									<td>4nets</td>
									<td>3.1 -> 2.5</td>
									<td>compiled</td>
								</tr>

								<tr>
									<th scope='row'>3</th>
									<td>Intent 4</td>
									<td>4nets</td>
									<td>1.1 -> 3.6</td>
									<td>uncompiled</td>
								</tr>
							</tbody>
						</table>
					</div>
								
					<div class="row flex-nowrap">
						<div class="col">
							<div class="card">
								<div class="card-header text-center">
									Intent Creation
								</div>
								<div class="card-body">
									<div class="row flex-nowrap">
										<div class="col d-flex justify-content-center">
											<select class="form-select btn btn-outline-light btn-lg domain domain_selection_select" id="domain_selection_1" aria-label="Domain 1" onchange="updateNodeList(1)">
												<option selected>Domain 1</option>
											</select>
										</div>

										<div class="col d-flex justify-content-center">	
											<select class="form-select btn btn-outline-light btn-lg domain node_selection_select_1" id="node_selection_1" aria-label="Node 1">
												<option selected>Node 1</option>
											</select>
										</div>
									</div>
									<div class="row flex-nowrap">
										<div class="col d-flex justify-content-center">
											<select class="form-select btn btn-outline-light btn-lg domain domain_selection_select" id="domain_selection_2" aria-label="Domain 2" onchange="updateNodeList(2)">
												<option selected>Domain 2</option>
											</select>
										</div>

										<div class="col d-flex justify-content-center">
											<select class="form-select btn btn-outline-light btn-lg domain node_selection_select_2" id="node_selection_2" aria-label="Node 2">
												<option selected>Node 2</option>
											</select>
										</div>
									</div>
									<div class="row flex-nowrap">
										<div class="col d-flex justify-content-center">
											<button class="btn btn-outline-light btn-lg create-intent node create_intent_button" onclick='createIntent()'>
												Create Intent
											</button>
										</div>

										<div class="col d-flex justify-content-center">
											<select class="form-select btn btn-outline-light btn-lg domain topology_select" id="topology_select" aria-label="Topology" onchange="updateDomainList()">
												<option selected>Topology</option>
												<option>4nets</option>
												<option>nobel-germany</option>
												<option>nobel-germany-france-topzoo</option>
											</select>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="card">
								<div class="card-header text-center">
									Drawing
								</div>
								<div class="card-body">
									<div class="row flex-nowrap">
										<div class="col d-flex justify-content-center">
											<select class="form-select btn btn-outline-light btn-lg domain intent_selection_select" id="intent_selection_select" aria-label="Available Intents">
												<option selected>Available Intents</option>
											</select>
										</div>

										<div class="col d-flex justify-content-center">
											<button class="btn btn-outline-light btn-lg create-intent node draw_button" onclick='drawIntent()'>
												Draw
											</button>
										</div>
									</div>
									<div class="row flex-nowrap">
										<div class="col d-flex justify-content-center">
											<select class="form-select btn btn-outline-light btn-lg domain plot_selection_select" id="plot_selection_select" aria-label="Plotting Type">
												<option selected>Plotting Type</option>
												<option>intentplot</option>
												<option>ibnplot</option>
											</select>
										</div>

										<div class="col d-flex justify-content-center">
											<button class="btn btn-outline-light btn-lg create-intent node">
												Remove
											</button>
										</div>
									</div>
									<div class="row flex-nowrap">
										<div class="col d-flex justify-content-center">
											<select class="form-select btn btn-outline-light btn-lg domain wanted_pos_select" id="wanted_pos_select" aria-label="Position">
												<option selected>Position</option>
												<option>1</option>
												<option>2</option>
											</select>
										</div>

										<div class="col d-flex justify-content-center">
											<button class="btn btn-outline-light btn-lg create-intent node">
												Placeholder
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>

  <style>

		body {
			background: linear-gradient(40deg, hsla(237, 90%, 4%, 1) 0%, hsla(266, 85%, 20%, 1) 100%);
			
		}
		
		.main {
			height: 30vh;
		}
		
		.main-card {
			width: 90vw;
			height: 90vh;
		
			margin: 5vh 0 5vh 0;
		
			background: rgba(251, 168, 255, 0.12);
			border-radius: 16px;
			box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
			backdrop-filter: blur(10px);
		}
		
		.menu-bar {
			height: 80vh;
			width: 10vw;
			padding: 2vh 1vw 2vh 1vw;
			margin: 2vh 2vw 2vh 2vh;

			padding-left: 12px;
			padding-right: 12px;
		}
		
		.top-desc {
			width: 10vw;
			height: 4vh;
			padding: 2vh 1vw 2vh 1vw;
			margin: 2vh 2vw 2vh 2vh;
		
			/*font-weight: bold;*/
			font-size: 16px;
			color: white;
		
			/*background: rgba(144, 81, 224, 0.34) !important;*/

			padding-left: 12px;
			padding-right: 12px;
		}
		
		.heading {
		
		}
		
		.menu-buttons {
			padding: 0vh 0 2vh 0;
			height: 5vh;
		}
		
		.settings {
			margin-top: 57.5vh;
		}
		
		.content {
			padding: 2vh 2vw 2vh 2vw;
		}
		
		.card, .menu-bar, .top-desc {
			background: rgba(217, 147, 232, 0.1);
			border-radius: 16px;
			box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
			/*backdrop-filter: blur(10.2px);*/
		}
		
		.card-header {
			padding: 20px 20px 0px 20px;
			font-weight: bold;
			font-size: 30px;
			color: white;
		}
		
		.domain, .node {
			max-width: 10vw;
			margin: 1vh 0vw 0 0;
			width: 10vw;
			min-width: 4vw;
		}
		
		.create-intent {
			width: 10vw;
			min-width: 5vw;
		}

		.title-span {
			font-weight: bold;
			font-size: 16px;
			color: white;
			background: transparent;
			border: none;
		}
		
		/*.div-creating {*/
		/*    width: 30vw;*/
		/*    margin-left: 10vw;*/
		/*}*/
		
		.div-editing {
			width: 50vw;
			margin-right: 10vw;
		}
		
		.create-intent:hover, .domain:hover, .node:hover, .domain:focus, .node:focus {
			background: #359b9b;
			color: white;
		}
		
		.create-intent:focus {
			background-color: rgba(255, 255, 255, 0);
		
		}

		.toast {
			background: rgba(96, 50, 107, 0.6);
			border-radius: 16px;
			box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
			margin-bottom: 1vh;
		}

		.toast-header {
			font-weight: bolder;
			color: white;
		}

		.toast-body {
			color: white;
		}



		.progress-bar {
			background: rgba(96, 50, 107, 0.6);
		}

		.table-container {
			padding: 1vh 1vw 1vh 1vw;

			background: rgba(217, 147, 232, 0.1);
			border-radius: 16px;
			box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
		}

		.table {
			background-color: transparent;
			color: white;
		}

		.action-buttons {
			width: 20vw;
		}

		tr {
			border-bottom: rgba(145, 132, 168, 0.46);
			border-style: solid;
		}


		pluto-logs-container {
			display: none;
		}

	</style>
  <!--!html-->
	""")

	return html_div


end


function testa()

end

export testa
