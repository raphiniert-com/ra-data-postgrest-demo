local utils = require 'utils'
local cjson = require 'cjson'

local function on_init()
    -- print "on_init called"
end

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function on_rest_request()
  -- print "on_rest_request called"
  local endpoint = ngx.var.uri:gsub(ngx.var.rest_prefix, '')
  local prefix = '/zombo_'

  local mintoken = tonumber(os.getenv('ZOMBO_SEARCH_MIN_TOKEN'))
  local maxresults = tonumber(os.getenv('ZOMBO_MAX_RESULTS'))

  -- check for endpoints starting with zombo_
  if endpoint:sub(1, #prefix) == prefix then
    local args, err = ngx.req.get_uri_args()
    if (args.query == nil) then
      args.query = 'eq.'
    end

    -- parse query
    local query_operator, query_string = args.query:match("([^%.]+)%.(.*)")

    if string.len(trim(query_string)) < mintoken then
      -- return empty result
      local jsonStr = '[]'
      ngx.header['Content-Type'] = 'application/json'
      ngx.header['Content-Range'] = '*/0'
      ngx.status = 200
      ngx.say(jsonStr)
      ngx.exit(200)
    end

    if query_operator == "eq" then
      ngx.req.set_header("query", query_string)
      ngx.req.set_header("limit", args.limit or maxresults)
      ngx.req.set_header("offset", args.offset or 0)
      ngx.req.set_header("order", args.order)
      args.query = nil
      -- args.limit = nil
      -- args.offset = nil
      -- args.order = nil
      ngx.req.set_uri_args(args)
    else
      -- throw error
      if query_operator == nil then
        local jsonStr = '{"error":"no operation given. Please use as \"query=eq.search term\"."}'
      else 
        local jsonStr = '{"error":"the attribute query only accepts operator eq."}'
      end
    
      ngx.header['Content-Type'] = 'application/json'
      ngx.status = 422
      ngx.say(jsonStr)
      ngx.exit(200)
    end
  end
end

local function before_rest_response()
    -- print "before_rest_response called"
    -- postprocess response
    -- utils.set_body_postprocess_mode(utils.postprocess_modes.ALL)
    -- utils.set_body_postprocess_fn(function(body)
    --     local b = cjson.decode(body)
    --     b.custom_key = 'custom_value'
    --     return cjson.encode(b)
    -- end)
end

return {
    on_init = on_init,
    on_rest_request = on_rest_request,
    before_rest_response = before_rest_response,
}