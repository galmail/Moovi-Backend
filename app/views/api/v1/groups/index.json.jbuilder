json.ignore_nil!
json.groups @groups do |group|
  json.id group.id
  json.name group.name
  json.description group.description
end
