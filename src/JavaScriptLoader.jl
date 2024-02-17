function open_file(path)
	f = open(path, "r")
	content = read(f, String)
	close(f)
	return content
end

function insert_scripts()
	#TODO put all constants (paths etc) in a .env file
	paths = []
	urls = ["https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-engine@2/tsparticles.engine.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-basic@2/tsparticles.basic.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-interaction-particles-links@2/tsparticles.interaction.particles.links.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-move-base@2/tsparticles.move.base.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-shape-circle@2/tsparticles.shape.circle.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-updater-color@2/tsparticles.updater.color.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-updater-opacity@2/tsparticles.updater.opacity.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-updater-out-modes@2/tsparticles.updater.out-modes.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-updater-size@2/tsparticles.updater.size.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-preset-triangles@2/tsparticles.preset.triangles.min.js",
		"https://cdn.jsdelivr.net/npm/tsparticles-preset-links@2/tsparticles.preset.links.min.js",
		"https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js",
	]

	#get all files in /scripts 
	files = readdir("MINDFulPluto/src/static/scripts")
	for file in files
		if file == "Init.js"
			continue
		end
		push!(paths, "MINDFulPluto/src/static/scripts/" * file)
	end

	#add init.js to paths
	push!(paths, "MINDFulPluto/src/static/scripts/Init.js")


	#insert scripts in paths
	scripts = []
	for path in paths
		push!(scripts, open_file(path))
	end


	return @htl("""
	<!-- html -->
	<script>

	//add bootstrap css to head if its not already there
	const bootstrapLink = "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	if (!document.querySelector('link[href="' + bootstrapLink + '"]')) {
		const bootstrap = document.createElement('link')
		bootstrap.rel = "stylesheet"
		bootstrap.href = bootstrapLink
		document.getElementsByTagName('head')[0].appendChild(bootstrap)
	}
	
	let scripts = $(scripts)
	const paths = $(paths)
	const urls = $(urls)
	const body = document.getElementsByTagName('body')[0]

	//add url scripts to body 
	for (let i = 0; i < urls.length; i++) {
		//check if script is already loaded
		if (document.querySelector('script[src="' + urls[i] + '"]')) {
			continue
		}

		//create script tag 
		const script = document.createElement('script')
		//add script url
		script.src = urls[i]
		//add script to body
		body.appendChild(script)
	}

	

	//add scripts to body
	addScriptLoop:
	for (let i = 0; i < scripts.length; i++) {
		//check if script is already loaded
		let queryScripts = document.querySelectorAll('script');
		for (let j = 0; j < queryScripts.length; j++) {
			if (queryScripts[j].className === paths[i]) {
				continue addScriptLoop
			}
		}

		console.log('added script ' + paths[i])
		

		//create script tag 
		let script = document.createElement('script')
		//add script content 
		script.innerHTML = scripts[i]
		//add path to className
		script.className = paths[i]
		//add script to body
		body.appendChild(script)
	}

	</script>
	<!-- !html -->
	""")

end

function get_dashboard_main_div()
	content = open_file("MINDFulPluto/src/static/html/DashboardIndex.html")
	html_div = HTML(content)
	return html_div
end

