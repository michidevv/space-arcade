Event = Base:extend()

Event.events = {}

function Event.dispatch(event, params)
  local listeners = Event.events[event]
  if listeners ~= nil then
    for _, v in ipairs(listeners)  do
      v(params)
    end
  end
end

function Event.subscribe(event, cb)
  local listeners = Event.events[event] or {}
  table.insert(listeners, cb)
  Event.events[event] = listeners

  -- Return unsubscribe function.
  return function ()
    for i, v in ipairs(listeners) do
      if v == cb then
        -- listeners[i] = nil -- TODO: Investigate
        table.remove(listeners, i)
      end
    end
  end
end
