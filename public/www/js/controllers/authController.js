/**
 * Auth controller.
 *
 */

gruvid.controllers.controller('AuthCtrl', function($scope, $ionicModal, $timeout, $location, Facebook, User) {

    /******** Facebook Part ********/

    var userIsConnected = false;
    
    $scope.$watch(
      function() {
        return Facebook.isReady();
      },
      function(newVal) {
        if (newVal)
          $scope.facebookReady = true;
      }
    );
    
    Facebook.getLoginStatus(function(response) {
      if (response.status == 'connected') {
        userIsConnected = true;
      }
    });

    
    $scope.fbLogin = function() {
      if(!userIsConnected) {
        Facebook.login(function(response) {
          if (response.status == 'connected') {
            $scope.logged = true;
            $scope.fbLoadUserInfo();
            $scope.closeLogin();
          }
        },{scope: 'email, user_birthday, user_friends'});
      } else {
        $scope.logged = true;
        $scope.fbLoadUserInfo();
        $scope.closeLogin();
      }
    };

    $scope.fbLogout = function() {
      Facebook.logout(function() {
        $scope.$apply(function() {
          $scope.user   = {};
          $scope.logged = false;
          User.setInfo({});
        });
      });
    };
    
    $scope.fbLoadUserInfo = function() {
      Facebook.api('/me', function(data) {
        User.setInfo(User.fbParseUserInfo(data));
        User.connect(function(){ $location.path('/'); });
      });
    };

    /******** Login Part ********/

    // Form data for the login modal
    $scope.loginData = {};

    // Create the login modal that we will use later
    $ionicModal.fromTemplateUrl('js/templates/login.html', {
      scope: $scope
    }).then(function(modal) {
      $scope.modal = modal;
    });

    // Triggered in the login modal to close it
    $scope.closeLogin = function() {
      $scope.modal.hide();
    };

    // Open the login modal
    $scope.login = function() {
      $scope.modal.show();
    };

    $scope.logout = function() {
      $scope.fbLogout();
    };

    // Perform the login action when the user submits the login form
    $scope.doLogin = function() {
      console.log('Doing login', $scope.loginData);

      // Simulate a login delay. Remove this and replace with your login
      // code if using a login system
      $timeout(function() {
        $scope.closeLogin();
      }, 1000);
    };

    
  });