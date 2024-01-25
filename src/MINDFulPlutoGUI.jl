module MINDFulPlutoGUI

using WGLMakie
using HypertextLiteral
using PlutoUI
using MINDFul
using NestedGraphsIO
using GraphIO
using NestedGraphs
using Graphs
using MetaGraphs
using MINDFulMakie
using Unitful

include("GUI.jl")
include("JSFunctions.jl")
include("SimpleNotebook.jl")
include("DashboardGUI.jl")
include("DashboardElements.jl")
include("Toasts.jl")


end # module MINDFulPlutoGUI
