using HTTP
using JSON
using URIs


"""
    mast_query(request::Dict) -> head,content

# Arguments
- `request::Dict`: A dictionary representing the MAST API request.

# Returns
- `head::Dict`: The header of the MAST API response.
- `content::Dict`: The content of the MAST API response.

# Description
Send a POST request to the MAST API with the given request dictionary and return the response header and content.
"""
function mast_query(request::Dict)
    request_url = "https://mast.stsci.edu/api/v0/invoke"

    version = VERSION |> string

    headers = [
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "text/plain",
        "User-Agent" => "julia-http/$version"
    ]

    req_string = JSON.json(request)
    req_string = URIs.escapeuri(req_string)

    body = "request=" * req_string

    resp = HTTP.post(request_url, headers, body)

    head = resp.headers
    content = String(resp.body)

    return head, content
end


"""
    set_filters(parameters::Dict) -> filters

# Arguments
- `parameters::Dict`: A dictionary of filter parameters.

# Returns
- `filters::Vector{Dict}`: A vector of filter dictionaries suitable for MAST API requests.

# Description
Convert a dictionary of filter parameters into a vector of filter dictionaries for MAST API requests.

"""
function set_filters(parameters::Dict)
    return [Dict("paramName" => p, "values" => v) for (p, v) in parameters]
end

"""
    set_min_max(min, max) -> filter

# Arguments
- `min`: Minimum value for the filter.
- `max`: Maximum value for the filter.

# Returns
- `filter::Vector{Dict}`: A vector containing a single dictionary with "min" and "max" keys.

# Description
Create a filter dictionary with specified minimum and maximum values for MAST API requests.
"""
function set_min_max(min, max)
    return [Dict("min" => min, "max" => max)]
end


"""
    ctl_advanced_search(filter_param::String, min_val::T, max_val::T) where T<:AbstractFloat -> nothing
# Arguments
- `filter_param::String`: The parameter name to filter on.
- `min_val::T`: The minimum value for the filter.
- `max_val::T`: The maximum value for the filter.   

# Returns
- `nothing`

# Description
Perform an advanced search on the CTL catalog using the specified filter parameter and value range, and print the count of matching sources.
"""
function ctl_advanced_search(filter_param::String, min_val::T, max_val::T) where T<:AbstractFloat
    filts = set_filters(Dict(
        filter_param => set_min_max(min_val, max_val)
    ))

    request = Dict(
        "service" => "Mast.Catalogs.Filtered.Ctl",
        "format" => "json",
        "params" => Dict(
            "columns" => "COUNT_BIG(*)",
            "filters" => filts
        )
    )

    headers, out_string = mast_query(request)
    out_data = JSON.parse(out_string)

    println("Number of sources with $filter_param between $min_val and $max_val: ", out_data["data"][1]["Column1"])
    return nothing
end




"""
    ctl_advanced_search_rows(filter_param::String, min_val::T, max_val::T, columns::String) where T<:AbstractFloat -> out_data
# Arguments
- `filter_param::String`: The parameter name to filter on.
- `min_val::T`: The minimum value for the filter.
- `max_val::T`: The maximum value for the filter.
- `columns::String`: Comma-separated string of columns to retrieve.

# Returns
- `out_data::Dict`: The parsed JSON response containing the requested rows.

# Description
Perform an advanced search on the CTL catalog using the specified filter parameter and value range, and retrieve the specified columns.
"""
function ctl_advanced_search_rows(filter_param::String, min_val::T, max_val::T, columns::String) where T<:AbstractFloat
    filts = set_filters(Dict(
        filter_param => set_min_max(min_val, max_val)
    ))

    request = Dict(
        "service" => "Mast.Catalogs.Filtered.Ctl.Rows",
        "format" => "json",
        "params" => Dict(
            "columns" => columns,
            "filters" => filts
        )
    )

    headers, out_string = mast_query(request)
    out_data = JSON.parse(out_string)

    return out_data
end

