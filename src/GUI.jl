function init()
	global intent_list = []
	global interactable_args = Dict()
	global fig = Figure(resolution = (800, 600))
	global fig_graphs = Any[nothing for i in 1:4]
	global button_wrapper = Dict(
		"create_intent" => [init_intent, 0],
		"compile_intent" => [compile_intent, 0],
		"uncompile_intent" => [uncompile_intent, 0],
		"install_intent" => [install_intent, 0],
		"uninstall_intent" => [uninstall_intent, 0],
		"remove_intent" => [remove_intent, 0],
		"draw" => [plot_intent, 0],
	)

	global viewport_settings = Dict(
		"width" => 0.0,
		"height" => 0.0,
		"dpr" => 0.0)

	global draw_args = Dict(
		"intent_index" => 0,
		"plotting_type" => "intentplot",
		"position" => 0)

	fig[1:2, 1:2] = GridLayout()
end


function init_intent(domain_1, domain_2, node_1, node_2, topology;)

	ibns = load_ibn("data/$(topology).graphml")
	myintent = create_intent(node_1, node_2, ibns[domain_1], ibns[domain_2])
	idi = add_intent_to_framework(myintent, ibns[domain_1])

	append!(intent_list, [Dict("id" => idi, "intent" => myintent, "ibns" => ibns, "sn" => domain_1, "name" => "intent" * string(length(intent_list) + 1) * "  " * topology,
		"n1" => node_1, "n2" => node_2, "n1_sn" => domain_1, "n2_sn" => domain_2, "topology" => topology)])
	return send_toast("Created Intent.")
end




function wrap_in_variable(; kwargs...)
	for (key::Symbol, val) in kwargs
		local key_str::String = string(key)
		if typeof(val) == Array{String, 1} || typeof(val) == Array{Int64, 1} || typeof(val) == Array{Any, 1}
			if length(val) == 1
				val = val[1]
			else
				val = nothing
			end
		end
		interactable_args[key_str] = val
	end
end



function button_caller_wrapper(func, button_counter; kwargs...)
	try
		return button_wrapper[func][1](; kwargs...)
	catch ArgumentError
		return send_toast("Error... Please check your input.")

	end
end

function update_domain_and_node_list(type; placeholder=nothing)
	if type == "domain"
		top = interactable_args["topology"]
		domain_names = 1:get_ibn_size(top)[1]
		return update_domain_list(domain_names)
		#if node in type
	elseif occursin("node", type)
		node_number = parse(Int64, type[5])
		top = interactable_args["topology"]
		domain = interactable_args["selection_n$(node_number)_sn"]
		node_names = get_nodes_of_subdomain(top, domain)

		return update_node_list(node_names, node_number)
	end
end

function trigger_update_of_draw_cell(intent_index, plotting_type, position)
	draw_args["intent_index"] = intent_index
	draw_args["plotting_type"] = plotting_type
	draw_args["position"] = position

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

#= function update_intent_list()

	intent_names = [x["name"] for x in intent_list]

	return @htl("""
	<!--html-->

	<script>
		//find intent list
		let intent_list = document.querySelector("#intent_selection_select");

		//find out which option was selected in intent_list
		let selected_value = intent_list.value;

		//clear intent list except first option
		while (intent_list.options.length > 1) {
			intent_list.remove(1);
		}

		//add intents to intent list
		$(intent_names).forEach((intent, i) => {


			let option = document.createElement("option");
			option.value = intent;
			option.innerHTML = intent;
			//check if intent was selected
			if (selected_value != undefined) {
				if (selected_value == intent) {
					option.selected = true;
				}
			}


			intent_list.appendChild(option);
		});
	console.log("updated intent list with selected intent: " + selected_value);
	</script>

	<!--!html-->
	""")
end =#
