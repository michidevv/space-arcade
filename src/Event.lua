Event = Base:extend()

Event.events = {}

function Event:dispatch(event, params)
  local listeners = Event.events[event]
  if listeners != nil and #listeners > 0 then
    for i=1, #listeners do
      listeners[i](params)
    end
  end
end

function Event:subscribe(event, cb)
  local listeners = Event.events[event]
  if listeners != nil then
    table.insert(listeners, cb)
  else
    Event.events[event] = {cb}
  end

  -- TODO: Return unsubscribe function.
  -- return
end
