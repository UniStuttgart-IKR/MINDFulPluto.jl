@compile_workload begin
	with_logger( ConsoleLogger(stderr, Logging.Warn) ) do 
		myibns = load_ibn("data/4nets.graphml")
		figt = Figure()
		ax1 = Axis(figt[1,1])
		myintent = ConnectivityIntent((myibns[1].id, 1), (myibns[3].id, 6), 50)
		idi = addintent!(myibns[1], myintent)
		deploy!(myibns[1], idi, MINDFul.docompile, MINDFul.SimpleIBNModus(), MINDFul.shortestavailpath!; time=nexttime());
		intentplot!(ax1, myibns[1], idi)
		deploy!(myibns[1], idi, MINDFul.doinstall, MINDFul.SimpleIBNModus(), MINDFul.directinstall!; time=nexttime());
		ax2 = Axis(figt[1,2])
		ibnplot!(ax2, myibns, intentidx=[idi])
	end
end
