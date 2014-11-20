/**
 * Video Service.
 *
 */

gruvid.services.factory('Video', function() {
  var VideoService = {};
  var list = [];
  VideoService.getItem = function(index) { return list[index]; }
  VideoService.addItem = function(item) { list.push(item); }
  VideoService.removeItem = function(item) { list.splice(list.indexOf(item), 1) }
  VideoService.size = function() { return list.length; }

  return VideoService;

});