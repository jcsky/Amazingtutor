json.array!(@booked_section) do |booked_section|
  json.start booked_section.start.to_time
  json.end booked_section.end.to_time
end