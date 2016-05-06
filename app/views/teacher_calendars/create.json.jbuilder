# json.array!(@return_insert_sections) do |insert_section|
  json.start @return_insert_sections.start.in_time_zone
  json.end @return_insert_sections.end.in_time_zone
# end