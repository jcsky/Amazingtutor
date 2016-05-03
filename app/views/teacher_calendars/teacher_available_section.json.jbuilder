
  json.array!(@available_section) do |available_section|
    json.start available_section.start.to_time
    json.end available_section.end.to_time
  end
