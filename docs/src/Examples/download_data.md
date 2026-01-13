# Example to download TESS CTL data using MAST API

This is an example to download all the 9.4 million stellar objects in CTL v8.01 database.  
Since we can download only maximum of 500K objects at one time. So we will break our downloads in several chunks.  

By looking at MAST website, we figured out that stars are $\approx$ uniformaly distributed in RA (Right Ascension),  
so we will make chunks based on this.  

## Necessary imports
```julia
using JSON
```

### Let's divide our RA space in 30 equal bins
```julia
bins = range(0.0, 360.0, length=30)
```

To make sure that all bins contains less than 500K stars, you can print stars in each bin as

```julia
for i in 1:29
    demographics.ctl_advanced_search("RA", bins[i], bins[i+1])
end
```

Let's now download actual data and save it in json file using [`demographics.ctl_advanced_search_rows`](@ref)

```julia
for i in 1:29
    out = demographics.ctl_advanced_search_rows("RA", bins[i], bins[i+1], "ID,mass,Tmag,Teff")
    open("CTL_TESS_DATA/CTL_$i.json", "w") do io
        JSON.print(io, out)
    end
    println("Done $i")
end
```

