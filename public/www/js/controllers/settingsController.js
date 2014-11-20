/**
 * Settings controller.
 *
 */

gruvid.controllers.controller('SettingsCtrl', function($scope, User) {
	$scope.user = User.LoggerUser;
	console.log(User.LoggerUser);
});
