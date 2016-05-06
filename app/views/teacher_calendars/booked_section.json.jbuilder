json.array!(@booked_section) do |booked_section|
  json.start booked_section.start.in_time_zone
  json.end booked_section.end.in_time_zone
end