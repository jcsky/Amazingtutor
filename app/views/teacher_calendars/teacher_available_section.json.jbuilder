
  json.array!(@available_section) do |available_section|
    json.start available_section.start.in_time_zone
    json.end available_section.end.in_time_zone
  end
