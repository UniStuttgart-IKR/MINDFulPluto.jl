function update_width_devving()
	#resizes the main cell so I can see the whole thing as well as all other cells
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
	domain_names = collect(1:get_ibn_size(topology)[1])

	return @htl("""
	<!--html-->
	<script>
	updateDomainListJS($(domain_names));	
	</script>
	<!--!html-->
	""")

end

function update_node_list(topology, domain, node_number)
	nodes = get_nodes_of_subdomain(topology, domain)

	return @htl("""
	<!--html-->
	<script>
	updateNodeListJS($(nodes), $(node_number));	
	</script>
	<!--!html-->
	""")

end
