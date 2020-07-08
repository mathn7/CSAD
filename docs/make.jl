using Documenter
using CSAD

makedocs(
    modules = [CSAD],
    sitename = "CSAD.jl",
    authors = "Saloua Naama, Mohamed El Waghf et Rachid ELMontassir",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [

            ]
    )

deploydocs(repo = "github.com/mathn7/CSAD.git")
