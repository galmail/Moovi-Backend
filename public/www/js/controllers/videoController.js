/**
 * Video controller.
 *
 */

gruvid.controllers.controller('VideoCtrl', function($scope, $stateParams, $ionicModal, filterFilter, $http, $ionicBackdrop, $timeout, $ionicLoading, $ionicSlideBoxDelegate, Facebook, Util, User) {

	$scope.params = $stateParams;
	$scope.videos = [];

  $scope.action = function(){
    $ionicBackdrop.retain();
    $timeout(function(){
      $ionicBackdrop.release();
    }, 1000);
  };

  $scope.show = function(msg){
  	var tpl = {};
  	tpl.template = msg || 'Loading...';
    $ionicLoading.show(tpl);
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
	$scope.participants = [];
	$scope.videoData = {
		id: Util.generateUUID(),
		cover: 'img/image_not_available.jpg',
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
		people: filterFilter($scope.participants,{hidden: false})
	};

	$scope.videoClipCover = 'img/video_not_available.png';
	$scope.uploadCompleteCallback = function(){
		if($scope.videoData.clip)
			$scope.videoClipCover = 'img/play.jpg';
	};

	// Create the participant modal
  $ionicModal.fromTemplateUrl('js/templates/participant.html', {
    scope: $scope
  }).then(function(modal) {
    $scope.modal = modal;
  });

	$scope.openContactDetails = function(i){
		$scope.selectedParticipantIndex = i;
		$scope.selectedParticipant = angular.copy($scope.participants[i]);
		$scope.modal.show();
	};

	$scope.closeContactDetails = function(){
		$scope.modal.hide();
	};

	$scope.saveContactDetails = function(){
		// validate email first
		if(!Util.validateEmail($scope.selectedParticipant.email)){
			alert('Not a valid email');
			return false;
		}
		if($scope.selectedParticipantIndex == -1){
			$scope.participants.unshift($scope.selectedParticipant);
		}
		else {
			$scope.participants[$scope.selectedParticipantIndex] = $scope.selectedParticipant;
		}
		$scope.closeContactDetails();
	};

	$scope.removeContactFromGroup = function(){
		$scope.participants[$scope.selectedParticipantIndex].hidden = true;
		$scope.closeContactDetails();
	};

	$scope.pickContactToGroup = function(){
		$scope.pickContact(function(contact){
			alert(JSON.stringify(contact));
		});
	};

	$scope.addContactToGroup = function(){
		$scope.selectedParticipantIndex = -1;
		$scope.selectedParticipant = { hidden: false };
		$scope.modal.show();
	};

	$scope.inviteGroup = function(){
		console.log('invite group');
		var people = filterFilter($scope.participants,{hidden: false});
		//User.inviteGroup(people);
	};

	$scope.sendInvitationToContact = function(){
		console.log('sendInvitationToContact');
		//User.inviteContact($scope.selectedParticipant);
		$scope.closeContactDetails();
	};

	$scope.saveVideo = function(){
		console.log('saveVideo');
		$scope.videoData.people = filterFilter($scope.participants,{hidden: false});
		
		$scope.show('Saving Video...');
		$http.post('/api/v1/videos.json', $scope.videoData)
		.success(function(){
			$scope.hide();
			alert('Video Saved Successfully!');
		})
		.error(function(){
			$scope.hide();
			alert('Could not save video!');
		});
	};

  	  

});
