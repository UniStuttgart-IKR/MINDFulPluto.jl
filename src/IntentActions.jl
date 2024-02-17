function create_intent(node_1, node_2, subnet_1, subnet_2)
	return ConnectivityIntent((subnet_1.id, node_1), (subnet_2.id, node_2), 50)
end

function add_intent_to_framework(intent, ibn)
	return addintent!(ibn, intent)
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

function defaultlinecards()
	return [
		MINDFul.LineCardDummy(10, 100, 26.72),
		MINDFul.LineCardDummy(2, 400, 29.36),
		MINDFul.LineCardDummy(1, 1000, 31.99),
	]
end

function defaultlinecardchassis()
	return [MINDFul.LineCardChassisDummy(Vector{MINDFul.LineCardDummy}(), 4.7, 16)]
end

function defaulttransmissionmodules()
	return [
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
end

function nexttime()
	return MINDFul.COUNTER("time")u"hr"
end
