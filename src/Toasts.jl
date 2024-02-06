function send_toast(message, title = "MINDFulPluto.jl")
	intent_names = [x["name"] for x in intent_list]
	intent_configs = [string(x["n1_sn"]) * "." * string(x["n1"]) * " -> " * string(x["n2_sn"]) * "." * string(x["n2"]) for x in intent_list]
	intent_toplogies = [x["topology"] for x in intent_list]
	intent_states = [get_intent_state(intent_list[i]["ibns"][intent_list[i]["sn"]], intent_list[i]["id"]) for i in 1:length(intent_list)]

	return @htl("""
	<!--html-->

	<script>
	
	add_toast_to_div($(title), $(message))

	//---------update intent-table---------

	updateIntentTable($(intent_names), $(intent_configs), $(intent_toplogies), $(intent_states))

	</script>
	<!--!html-->
	""")


end
