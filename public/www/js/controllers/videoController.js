/**
 * Video controller.
 *
 */

gruvid.controllers.controller('VideoCtrl', function($scope, $stateParams, $http, $ionicBackdrop, $timeout, $ionicLoading, $ionicSlideBoxDelegate, Facebook, Util) {

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

	$scope.pickContact = function(callback){
		if(navigator.contacts){
			navigator.contacts.pickContact(callback);
		}
		else {
			alert('Download the app to select from contact list');
		}
	};

	$scope.selectReceiverFromContactList = function(){
		$scope.pickContact(function(contact){
			alert(JSON.stringify(contact));
		});
	};

	$scope.addContactToGroup = function(){
		$scope.pickContact(function(contact){

		});
	};

	$scope.showOtherOcassion = function(){
		if(!$scope._otherOcassion){
			$scope._otherOcassion=true;
			$scope.videoData.ocassion.name='';
		}
		$scope._otherOcassionColor = 'color:black;';
	};

	$scope.hideOtherOcassion = function(){
		$scope._otherOcassionColor = 'color:white;';
		$scope._otherOcassion=false;
	};
	$scope.hideOtherOcassion();	

	$scope.firstSlide = function(){
		return ($ionicSlideBoxDelegate.currentIndex() == 0);
	};

	$scope.lastSlide = function(){
		return ($ionicSlideBoxDelegate.slidesCount()-$ionicSlideBoxDelegate.currentIndex()==1);
	};

	$scope.nextSlide = function(){
		$ionicSlideBoxDelegate.next();
	};

	$scope.previousSlide = function(){
		$ionicSlideBoxDelegate.previous();
	};


	$scope.coverMaxHeight = window.innerWidth + 'px';
	
	$scope.videoData = {
		id: Util.generateUUID(),
		cover: '/img/image_not_available.jpg',
		clip: null,
		ocassion: {
			name: 'Birthday',
			date: '12/12/2014'
		},
		receiver: {
			first_name: null,
			last_name: null,
			email: null,
			gender: 'M',
			birthdate: null
		},
		participants: [
			{ first_name: null, last_name: null, email: null, mobile: null }
		]
	};

	$scope.videoClipCover = '/img/video_not_available.png';
	$scope.uploadCompleteCallback = function(){
		if($scope.videoData.clip)
			$scope.videoClipCover = '/img/play.jpg';
	};

	$scope.saveVideo = function(){
		console.log('saveVideo');
		console.log($scope.videoData.title);
		$http.post('/api/v1/videos.json', $scope.videoData)
		.success(function(){
			alert('Video Saved Successfully!');
		})
		.error(function(){
			alert('Could not save video!');
		});
	};

  	  

});
