
  json.array!(@event_result) do |event_result|
    json.id event_result[:id]
    json.backgroundColor event_result[:backgroundColor]
    json.rendering 'background'
    json.start event_result[:start].in_time_zone
    json.end event_result[:end].in_time_zone
  end
