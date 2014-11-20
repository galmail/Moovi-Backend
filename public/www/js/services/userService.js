/**
 * User Service.
 *
 */

gruvid.services.factory('User', function($http) {
  var data = {};
  return {
  	getInfo: function(){ return data; },
  	setInfo: function(newdata){ data = newdata; },
  	login: function(callback){
  		$http.get('/users/sign_in',{
  			params: {
  				email: data.email,
  				password: data.password
  			}
  		}).success(function(data){
  			console.log('login success: ' + JSON.stringify(data));
  			// save auth_token
  			callback(true);
  		}).error(function(data){
  			console.log('login error: ' + JSON.stringify(data));
  			callback(false);
  		});
  	},
  	signup: function(callback){
  		var self = this;
  		$http.get('/users/sign_up',{
  			params: data
  		}).success(function(data){
  			console.log('signup success: ' + JSON.stringify(data));
  			self.login(callback);
  		}).error(function(data){
  			console.log('signup error: ' + JSON.stringify(data));
  			callback(false);
  		});
  	},
  	connect: function(callback){
  		var self = this;
  		// try login first if fail, try to signup user
  		console.log('inside connect... trying to login first.');
  		self.login().then(function(ok){
  			if(ok){
  				callback(true);
  			}
  			else {
  				self.signup().then(function(ok){
  					callback(ok);
  				});
  			}
  		});
  	}
  };

});