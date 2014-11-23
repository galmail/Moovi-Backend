/**
 * Video controller.
 *
 */

gruvid.controllers.controller('VideoCtrl', function($scope, $stateParams, $http, $ionicBackdrop, $timeout, $ionicLoading) {

	$scope.params = $stateParams;
	$scope.videos = [];

  $scope.action = function(){
    $ionicBackdrop.retain();
    $timeout(function(){
      $ionicBackdrop.release();
    }, 1000);
  };

  $scope.show = function(){
    $ionicLoading.show({
      template: 'Loading...'
    });
  };

  $scope.hide = function(){
    $ionicLoading.hide();
  };

	$scope.loadVideos = function(){
		//$scope.show();
		$http.get('/api/v1/videos.json').success(function(data){
			$scope.videos = data;
			if(data){
				console.log('Fetched videos: ' + JSON.stringify(data));
			}
			else {
				console.log('no videos available...');
			}
			//$scope.hide();
		});
	};

	$scope.loadVideos();

	$scope.pickContact = function(){
		if(navigator.contacts){
			navigator.contacts.pickContact(function(contact){
					alert(JSON.stringify(contact));
	        console.log('The following contact has been selected:' + JSON.stringify(contact));
	    },function(err){
	        console.log('Error: ' + err);
	    });
		}
		else {
			alert('Download the app to select from contact list');
		}
	};

	$scope.saveVideo = function(){
		//$http.post('/api/v1/videos.json', {msg:'hello word!'});
	};











  	


  	  

});
