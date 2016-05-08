
  json.array!(@event_result) do |event_result|
    json.id event_result[:id]
    if event_result[:color].nil?
      json.backgroundColor event_result[:backgroundColor]
      json.rendering 'background'
    else
      json.borderColor event_result[:borderColor]
      json.color event_result[:color]
      json.title event_result[:title]
      json.textColor event_result[:textColor]
    end
    json.start event_result[:start].in_time_zone
    json.end event_result[:end].in_time_zone
  end
