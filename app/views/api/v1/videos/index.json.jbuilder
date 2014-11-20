json.ignore_nil!
json.videos @videos do |video|
  json.id video.id
  json.user_id video.user_id
  json.title video.title
  json.url video.url
end
