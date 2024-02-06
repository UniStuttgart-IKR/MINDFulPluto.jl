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
	#return fig_graphs[position]




end

function compile_intent(index;)
	#intent_selection = interactable_args["selection_intent"]

	#get index of element in intent_list with name = intent_selection
	#index = findfirst(x -> x["name"] == intent_selection, intent_list)
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

function create_intent(node_1, node_2, subnet_1, subnet_2)
	return ConnectivityIntent((subnet_1.id, node_1), (subnet_2.id, node_2), 50)
end

function add_intent_to_framework(intent, ibn)
	return addintent!(ibn, intent)
end

function install_intent(index;)
	#intent_selection = interactable_args["selection_intent"]

	#index = findfirst(x -> x["name"] == intent_selection, intent_list)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]
	deploy!(ibn, idi, MINDFul.doinstall, MINDFul.SimpleIBNModus(), MINDFul.directinstall!; time = nexttime())

	return send_toast("Intent installed.")
end

function uninstall_intent(index;)
	#intent_selection = interactable_args["selection_intent"]

	#index = findfirst(x -> x["name"] == intent_selection, intent_list)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

	deploy!(ibn, idi, MINDFul.douninstall, MINDFul.SimpleIBNModus(), MINDFul.directuninstall!; time = nexttime())

	return send_toast("Intent uninstalled.")
end

function uncompile_intent(index;)
	#intent_selection = interactable_args["selection_intent"]

	#index = findfirst(x -> x["name"] == intent_selection, intent_list)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

	deploy!(ibn, idi, MINDFul.douncompile, MINDFul.SimpleIBNModus(); time = nexttime())

	return send_toast("Intent uncompiled.")
end

function remove_intent(index;)
	#intent_selection = interactable_args["selection_intent"]

	#index = findfirst(x -> x["name"] == intent_selection, intent_list)
	intent = intent_list[index]
	ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

	remintent!(ibn, idi)
	deleteat!(intent_list, index)

	return send_toast("Intent removed.")
end

function load_ibn(topology_path)
	# read in the NestedGraph
	globalnet = open(joinpath(topology_path)) do io
		loadgraph(io, "global-network", GraphIO.GraphML.GraphMLFormat(), NestedGraphs.NestedGraphFormat())
	end

	# convert it to a NestedGraph compliant with the simulation specifications
	simgraph = MINDFul.simgraph(globalnet;
		distance_method = MINDFul.euclidean_dist,
		router_lcpool = defaultlinecards(),
		router_lccpool = defaultlinecardchassis(),
		router_lcccap = 3,
		transponderset = defaulttransmissionmodules())

	# convert it to IBNs
	myibns = MINDFul.nestedGraph2IBNs!(simgraph)

	return myibns
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

function get_ibn_size(topology)
	return size(load_ibn("data/" * topology * ".graphml"))
end

function get_nodes_of_subdomain(top, domain)
	ibn = load_ibn("data/" * top * ".graphml")
	return MINDFul.getmynodes(ibn[parse(Int64, domain)])
end

function get_intent_state(ibn, id)
	#gets the current intent state
	#split string at ::
	return split(string(getintentnode(ibn, id).state), "::")[1]

end

defaultlinecards() = [MINDFul.LineCardDummy(10, 100, 26.72), MINDFul.LineCardDummy(2, 400, 29.36), MINDFul.LineCardDummy(1, 1000, 31.99)]
defaultlinecardchassis() = [MINDFul.LineCardChassisDummy(Vector{MINDFul.LineCardDummy}(), 4.7, 16)]
defaulttransmissionmodules() = [
	MINDFul.TransmissionModuleView("DummyFlexibleTransponder",
		MINDFul.TransmissionModuleDummy(
			[MINDFul.TransmissionProps(5080.0u"km", 300, 8),
				MINDFul.TransmissionProps(4400.0u"km", 400, 8),
				MINDFul.TransmissionProps(2800.0u"km", 500, 8),
				MINDFul.TransmissionProps(1200.0u"km", 600, 8),
				MINDFul.TransmissionProps(700.0u"km", 700, 10),
				MINDFul.TransmissionProps(400.0u"km", 800, 10)], 0, 20)),
	MINDFul.TransmissionModuleView("DummyFlexiblePluggables",
		MINDFul.TransmissionModuleDummy([MINDFul.TransmissionProps(5840.0u"km", 100, 4),
				MINDFul.TransmissionProps(2880.0u"km", 200, 6),
				MINDFul.TransmissionProps(1600.0u"km", 300, 6),
				MINDFul.TransmissionProps(480.0u"km", 400, 6)], 0, 8)),
]
nexttime() = MINDFul.COUNTER("time")u"hr"
