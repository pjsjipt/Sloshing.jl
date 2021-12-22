using Sloshing
using Documenter

DocMeta.setdocmeta!(Sloshing, :DocTestSetup, :(using Sloshing); recursive=true)

makedocs(;
    modules=[Sloshing],
    authors="Paulo Jabardo <pjabardo@ipt.br>",
    repo="https://github.com/pjsjipt/Sloshing.jl/blob/{commit}{path}#{line}",
    sitename="Sloshing.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
