-- TODO: Consider consistent usage of io.write

local function introspect (table, deep, spaces)
    assert(type(table) == 'table', 'Expected table, receved: ' .. tostring(table))

    deep = deep or 0
    spaces = spaces or 2

    local indent = string.rep(' ', deep * spaces)
    local propIndent = string.rep(' ', (deep + 1) * spaces)

    print((deep == 0 and indent or '') .. '{')

    for k, v in pairs(table) do
        if type(v) == 'table' then
            io.write(propIndent .. tostring(k) .. ' = ') -- Prevent from adding a newline.
            introspect(v, deep + 1)
        else
            print(propIndent .. tostring(k) .. ' = ' .. tostring(v) .. ', ')
        end
    end

    print(indent .. '}' .. (deep > 0 and ',' or ''))
end

return { introspect = introspect }

