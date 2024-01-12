module MINDFulPlutoGUI

using WGLMakie
using HypertextLiteral
using PlutoUI

using MINDFul, NestedGraphsIO, GraphIO, NestedGraphs, Graphs, MetaGraphs

using MINDFulMakie, Unitful
include("GUI.jl")
include("JSFunctions.jl")
include("SimpleNotebook.jl")
include("DashboardGUI.jl")
include("DashboardElements.jl")


end # module MINDFulPlutoGUI
