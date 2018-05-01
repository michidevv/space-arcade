Event = Base:extend()

Event.events = {}

function Event.dispatch(event, params)
  local listeners = Event.events[event]
  if listeners ~= nil and #listeners > 0 then
    for i=1, #listeners do
      listeners[i](params)
    end
  end
end

function Event.subscribe(event, cb)
  local listeners = Event.events[event] or {}
  table.insert(listeners, cb)
  Event.events[event] = listeners

  -- Return unsubscribe function.
  return function ()
    table.remove(listeners, #listeners)
  end
end
