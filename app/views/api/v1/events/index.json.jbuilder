json.ignore_nil!
json.events @events do |event|
  json.id event.id
  json.name event.name
  json.pic_url event.pic_url
end
