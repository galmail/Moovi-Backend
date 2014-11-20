// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.controllers' is found in controllers.js

var gruvid = angular.module('gruvid',['ionic','facebook','gruvid.controllers','gruvid.services','gruvid.directives']);
gruvid.controllers = angular.module('gruvid.controllers', []);
gruvid.services = angular.module('gruvid.services', []);
gruvid.directives = angular.module('gruvid.directives', []);

gruvid.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
})

.config(function(FacebookProvider) {
   var fbAppId = '';
   if(window.location.href.indexOf('localhost')>0){
    fbAppId = '854877257866349';
   }
   else {
    fbAppId = '672126826238840';
   }
   FacebookProvider.init(fbAppId);
})

.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

  .state('app', {
    url: "/app",
    abstract: true,
    templateUrl: "js/templates/_menu.html",
    controller: 'AuthCtrl'
  })

  .state('app.videos', {
    url: "/videos",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/videos.html",
        controller: 'VideoCtrl'
      }
    }
  })
  .state('app.singleVideo', {
    url: "/videos/:videoId",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/video.html",
        controller: 'VideoCtrl'
      }
    }
  })
  .state('app.createVideo', {
    url: "/create-video",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/create-video.html"
      }
    }
  })
  .state('app.joinVideo', {
    url: "/join-video",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/join-video.html"
      }
    }
  })
  .state('app.settings', {
    url: "/settings",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/settings.html",
        controller: 'SettingsCtrl'
      }
    }
  })
  .state('app.about', {
    url: "/about",
    views: {
      'menuContent' :{
        templateUrl: "js/templates/about.html"
      }
    }
  });

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/app/videos');

});

