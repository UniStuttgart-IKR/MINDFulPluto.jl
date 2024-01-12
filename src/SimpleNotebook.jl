function plot_intent(;)
    intent_selection = interactable_args["selection_intent"]
    plot_selection = interactable_args["selection_plot"]
    wanted_pos = parse(Int64, interactable_args["selection_pos"])


    #get index of element in intent_list with name = intent_selection
    index = findfirst(x -> x["name"] == intent_selection, intent_list)
    intent = intent_list[index]

    ibn = intent["ibns"][intent["sn"]]
    idi = intent["id"]

    #= ax = Axis(fig[pos_to_matrix(wanted_pos)[1], pos_to_matrix(wanted_pos)[2]])
    intentplot!(ax, ibn, idi)

    return fig =#

    set_theme!(theme_black())

    fig = Figure(resolution=(1070,940))
    ax = Axis(fig[1,1])

    if plot_selection == "intentplot"
        fig_graphs[wanted_pos] = intentplot!(ax, ibn, idi)
    elseif plot_selection == "ibnplot"
        fig_graphs[wanted_pos] = ibnplot!(ax, ibn, intentidx=[idi])
    end

    return fig
    return fig_graphs[wanted_pos]




end

function compile_intent(;)
    intent_selection = interactable_args["selection_intent"]

    #get index of element in intent_list with name = intent_selection
    index = findfirst(x -> x["name"] == intent_selection, intent_list)
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
    deploy!(ibn, idi, MINDFul.docompile, MINDFul.SimpleIBNModus(), algo; time=nexttime())
end

function create_intent(node_1, node_2, subnet_1, subnet_2)
    return ConnectivityIntent((subnet_1.id, node_1), (subnet_2.id, node_2), 50)
end

function add_intent_to_framework(intent, ibn)
    return addintent!(ibn, intent)
end

function install_intent(;)
    intent_selection = interactable_args["selection_intent"]

    index = findfirst(x -> x["name"] == intent_selection, intent_list)
    intent = intent_list[index]
    ibn, idi = intent["ibns"][intent["sn"]], intent["id"]
    deploy!(ibn, idi, MINDFul.doinstall, MINDFul.SimpleIBNModus(), MINDFul.directinstall!; time=nexttime())

end

function uninstall_intent(;)
    intent_selection = interactable_args["selection_intent"]

    index = findfirst(x -> x["name"] == intent_selection, intent_list)
    intent = intent_list[index]
    ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

    deploy!(ibn, idi, MINDFul.douninstall, MINDFul.SimpleIBNModus(), MINDFul.directuninstall!; time=nexttime())

end

function uncompile_intent(;)
    intent_selection = interactable_args["selection_intent"]

    index = findfirst(x -> x["name"] == intent_selection, intent_list)
    intent = intent_list[index]
    ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

    deploy!(ibn, idi, MINDFul.douncompile, MINDFul.SimpleIBNModus(); time=nexttime())

end

function remove_intent(;)
    intent_selection = interactable_args["selection_intent"]

    index = findfirst(x -> x["name"] == intent_selection, intent_list)
    intent = intent_list[index]
    ibn, idi = intent["ibns"][intent["sn"]], intent["id"]

    remintent!(ibn, idi)
end

function load_ibn(topology_path)
    # read in the NestedGraph
    globalnet = open(joinpath(topology_path)) do io
        loadgraph(io, "global-network", GraphIO.GraphML.GraphMLFormat(), NestedGraphs.NestedGraphFormat())
    end

    # convert it to a NestedGraph compliant with the simulation specifications
    simgraph = MINDFul.simgraph(globalnet;
        distance_method=MINDFul.euclidean_dist,
        router_lcpool=defaultlinecards(),
        router_lccpool=defaultlinecardchassis(),
        router_lcccap=3,
        transponderset=defaulttransmissionmodules())

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

defaultlinecards() = [MINDFul.LineCardDummy(10, 100, 26.72), MINDFul.LineCardDummy(2, 400, 29.36), MINDFul.LineCardDummy(1, 1000, 31.99)]
defaultlinecardchassis() = [MINDFul.LineCardChassisDummy(Vector{MINDFul.LineCardDummy}(), 4.7, 16)]
defaulttransmissionmodules() = [MINDFul.TransmissionModuleView("DummyFlexibleTransponder",
        MINDFul.TransmissionModuleDummy([MINDFul.TransmissionProps(5080.0u"km", 300, 8),
                MINDFul.TransmissionProps(4400.0u"km", 400, 8),
                MINDFul.TransmissionProps(2800.0u"km", 500, 8),
                MINDFul.TransmissionProps(1200.0u"km", 600, 8),
                MINDFul.TransmissionProps(700.0u"km", 700, 10),
                MINDFul.TransmissionProps(400.0u"km", 800, 10)], 0, 20)),
    MINDFul.TransmissionModuleView("DummyFlexiblePluggables",
        MINDFul.TransmissionModuleDummy([MINDFul.TransmissionProps(5840.0u"km", 100, 4),
                MINDFul.TransmissionProps(2880.0u"km", 200, 6),
                MINDFul.TransmissionProps(1600.0u"km", 300, 6),
                MINDFul.TransmissionProps(480.0u"km", 400, 6)], 0, 8))
]
nexttime() = MINDFul.COUNTER("time")u"hr"