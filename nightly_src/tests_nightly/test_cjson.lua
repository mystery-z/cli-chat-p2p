local cjson = require "cjson"

local json = cjson.encode({
    foo = "bar",
    some_object = {},
    some_array = cjson.empty_array
})

print(json)

--~ cjson install issues: https://github.com/openresty/lua-cjson/issues/67#issuecomment-1159001389
