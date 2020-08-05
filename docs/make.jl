using Documenter
using CSAD

makedocs(
    modules = [CSAD],
    sitename = "CSAD.jl",
    authors = "Saloua Naama, Mohamed El Waghf et Rachid ELMontassir",
    format = Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages = [
            "Accueil" => "index.md",
            "Sujets" => [
                "TP1"=>"sujet-tp1.md",
                "TP2"=>"sujet-tp2.md",
                "TP3"=>"sujet-tp3.md"
            ]
            ]
    )

deploydocs(repo = "github.com/mathn7/CSAD.git")
