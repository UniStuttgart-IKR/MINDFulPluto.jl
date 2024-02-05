function open_file(path)
	f = open(path, "r")
	content = read(f, String)
	close(f)
	return content
end

function insert_scripts()
	paths = ["data/tsparticlesconfig.js", "data/toasts.js", "data/scripts/GetViewportSize.js"]
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

	#insert scripts in paths
	scripts = []
	for path in paths
		push!(scripts, open_file(path))
	end

	return @htl("""
	<!-- html -->
	<script>
	
	const scripts = $(scripts)
    const urls = $(urls)
	const body = document.getElementsByTagName('body')[0]

    //add url scripts to body 
    for (let i = 0; i < urls.length; i++) {
        //create script tag 
        const script = document.createElement('script')
        //add script url
        script.src = urls[i]
        //add script to body
        body.appendChild(script)
    }

	//add scripts to body
	for (let i = 0; i < scripts.length; i++) {
		//create script tag 
		const script = document.createElement('script')
		//add script content 
		script.innerHTML = scripts[i]
		//add script to body
		body.appendChild(script)
	}

	</script>
	<!-- !html -->
	""")

end
