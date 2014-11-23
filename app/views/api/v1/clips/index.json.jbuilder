json.ignore_nil!
json.clips @clips do |clip|
  json.id clip.id
  json.video_id clip.video_id
  json.url clip.url
  json.message clip.message
end
