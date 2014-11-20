/**
 * Video controller.
 *
 */

gruvid.controllers.controller('VideoCtrl', function($scope, $stateParams, $http) {

	$scope.videos = [];

	$http.get('/json/videos.json').success(function(data){
		 $scope.videos = data;
	});

  	$scope.params = $stateParams;


});
