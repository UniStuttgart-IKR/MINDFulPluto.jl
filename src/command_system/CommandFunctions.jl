function plot_intent()
	if length(intent_list) == 0
		return nothing
	end

	intent_index = draw_args["intent_index"]
	plotting_type = draw_args["plotting_type"]
	position = draw_args["position"]
	domain = draw_args["domain"]

	intent = intent_list[intent_index]

	ibn = intent["ibns"]
	idi = intent["id"]

	set_theme!(theme_black())

	dpr = viewport_settings["dpr"]
	fig = Figure(resolution = (round(713 * dpr, digits = 0), round(625 * dpr, digits = 0)))
	ax = Axis(fig[1, 1])

	if plotting_type == "intentplot"
		fig_graphs[position] = intentplot!(ax, ibn[domain], idi)
	elseif plotting_type == "ibnplot"
		if domain == 0
			fig_graphs[position] = ibnplot!(ax, ibn, intentidx = [idi])
		else
			fig_graphs[position] = ibnplot!(ax, ibn[domain], intentidx = [idi])
		end
	end

	return fig
end

function init_intent(domain_1, domain_2, node_1, node_2, topology;)

	ibns = load_ibn("data/$(topology).graphml")
	myintent = create_intent(node_1, node_2, ibns[domain_1], ibns[domain_2])
	idi = add_intent_to_framework(myintent, ibns[domain_1])

	append!(
		intent_list,
		[Dict("id" => idi, "intent" => myintent, "ibns" => ibns, "sn" => domain_1, "name" => "intent" * string(length(intent_list) + 1) * "  " * topology,
			"n1" => node_1, "n2" => node_2, "n1_sn" => domain_1, "n2_sn" => domain_2, "topology" => topology)],
	)
	return send_toast("Created Intent.")
end

function compile_intent(index)
	intent = intent_list[index]
	algorithm = "shortestavailpath"

	if algorithm == "shortestavailpath"
		algo = MINDFul.shortestavailpath!
		#those algos are not fully implemented yet
	elseif algorithm == "jointrmsagenerilizeddijkstra"
		algo = MINDFulCompanion.jointrmsagenerilizeddijkstra!
	elseif algorithm == "longestavailpath"
		algo = longestavailpath!
	end

	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]
	deploy!(ibn, idi, MINDFul.docompile, MINDFul.SimpleIBNModus(), algo; time = nexttime())

	return send_toast("Intent compiled.")
end

function uncompile_intent(index)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

	deploy!(ibn, idi, MINDFul.douncompile, MINDFul.SimpleIBNModus(); time = nexttime())

	return send_toast("Intent uncompiled.")
end

function install_intent(index;)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]
	deploy!(ibn, idi, MINDFul.doinstall, MINDFul.SimpleIBNModus(), MINDFul.directinstall!; time = nexttime())

	return send_toast("Intent installed.")
end

function uninstall_intent(index)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

	deploy!(ibn, idi, MINDFul.douninstall, MINDFul.SimpleIBNModus(), MINDFul.directuninstall!; time = nexttime())

	return send_toast("Intent uninstalled.")
end

function remove_intent(index)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

	remintent!(ibn, idi)
	deleteat!(intent_list, index)

	return send_toast("Intent removed.")
end

function update_domain_list_drawing(intent_index, plotting_type)
	if length(intent_list) == 0
		return nothing
	end

	if plotting_type == "ibnplot"
		domains = ["All", intent_list[intent_index]["sn"]]
	elseif plotting_type == "intentplot"
		domains = [intent_list[intent_index]["sn"]]
	end

	return @htl("""
		<script>
		updateDomainDrawingList($(domains))
		</script>
		""")
end

function trigger_update_of_draw_cell(intent_index, plotting_type, position, domain)
	draw_args["intent_index"] = intent_index
	draw_args["plotting_type"] = plotting_type
	draw_args["position"] = position
	draw_args["domain"] = domain

	return @htl("""
   <!--html-->

   <script>
	   
	   // Get current cell handle and ID
	   let cell = currentScript.closest("pluto-cell")
	   //let id = cell.getAttribute("id")
	   let draw_cells = ["36ded27e-079a-4bed-9d94-abd6314ddca8", "dcad27db-f258-4ac8-a17b-21397933a3a1"]

	   console.log("Updating cell: " + ($(position)));
	   // Use the pluto internal function to re-run all selected cells
	   cell._internal_pluto_actions.set_and_run_multiple([draw_cells[$(position-1)]])
   </script>

   <!--!html-->
   """)
end


