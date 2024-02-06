function handle_command(command)
	#command consist of <action> args...
	#parse command 
	action = split(command, " ")[1]

	action_wrapper = Dict(
		"compile_intent" => compile_intent,
		"uncompile_intent" => uncompile_intent,
		"install_intent" => install_intent,
		"uninstall_intent" => uninstall_intent,
		"remove_intent" => remove_intent)

	creation_wrapper = Dict(
		"create_intent" => init_intent,
	)

	draw_wrapper = Dict(
		"draw_intent" => trigger_update_of_draw_cell,
	)


	try
		if action in keys(action_wrapper)
			action, target_index = split(command, " ") #compile_intent <target_index>
			target_index = parse(Int64, target_index)

			action_wrapper[action](target_index)
			return send_toast("Command: $command executed.")

		elseif action in keys(creation_wrapper)
			action, domain_1, domain_2, node_1, node_2, topology = split(command, " ") #create_intent <domain_1> <domain_2> <node_1> <node_2> <topology>
			domain_1, node_1, domain_2, node_2 = parse(Int64, domain_1), parse(Int64, node_1), parse(Int64, domain_2), parse(Int64, node_2)

			creation_wrapper[action](domain_1, domain_2, node_1, node_2, topology)
			return send_toast("Command: $command executed.")

		elseif action in keys(draw_wrapper)
            action, intent_index, plotting_type, position = split(command, " ") #draw <intent_index> <plotting_type> <position>
            intent_index, position = parse(Int64, intent_index), parse(Int64, position)
			return draw_wrapper[action](intent_index, plotting_type, position)

		elseif action == "update_domain_list"
			action, topology = split(command, " ") #update_domain_list <topology>
			return update_domain_list(topology)

		elseif action == "update_node_list"
			action, topology, domain, node_number = split(command, " ") #update_node_list <topology> <domain> <node_number>
			node_number = parse(Int64, node_number)
			return update_node_list(topology, domain, node_number)
		end
	catch e
		return send_toast("Error: $e")
	end




end
