using demographics
using Documenter

DocMeta.setdocmeta!(demographics, :DocTestSetup, :(using demographics); recursive=true)

makedocs(;
    modules=[demographics],
    authors="Avinash Verma <avinash.verma@niser.ac.in> and contributors",
    sitename="demographics.jl",
    format=Documenter.HTML(;
        canonical="https://avnsh9.github.io/demographics.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/avnsh9/demographics.jl",
    devbranch="main",
)
