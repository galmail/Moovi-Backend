json.ignore_nil!
json.videos @videos do |video|
  json.id video.id
  json.moderator_id video.moderator_id
  json.receiver_id video.receiver_id
  json.title video.title
  json.url video.url
end
