module MINDFulPluto

using GraphIO
using Graphs
using HypertextLiteral
using Logging
using MINDFul
using MINDFulMakie
using MetaGraphs
using NestedGraphs
using NestedGraphsIO
using PlutoUI
using PrecompileTools
using Unitful
using WGLMakie

include("JSFunctions.jl")
include("IntentActions.jl")
include("Toasts.jl")
include("JavaScriptLoader.jl")
include("command_system/HandleCommands.jl")
include("command_system/CommandFunctions.jl")
include("precompile.jl")


intent_list = []
fig_graphs = Any[nothing for i in 1:4]

viewport_settings = Dict(
	"width" => 0.0,
	"height" => 0.0,
	"dpr" => 0.0)

draw_args = Dict(
	"intent_index" => 0,
	"plotting_type" => "intentplot",
	"position" => 0,
	"domain" => 0)

end # module MINDFulPlutoGUI
