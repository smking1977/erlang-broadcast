	// create the module and name it scotchApp
	var scotchApp = angular.module('scotchApp', ['ngRoute']);

	// configure our routes
	scotchApp.config(function($routeProvider) {
		$routeProvider

			// route for the home page
			.when('/', {
				templateUrl : 'pages/home.html',
				controller  : 'mainController'
			})

			// route for the about page
			.when('/about', {
				templateUrl : 'pages/about.html',
				controller  : 'aboutController'
			})
			// route for the handball page
			.when('/handball', {
				templateUrl : 'pages/handball.html',
				controller  : 'handballController'
			})
            // route for the baseball page
            .when('/baseball', {
                templateUrl : 'pages/baseball.html',
                controller  : 'baseballController'
            })
            // route for the dm page
            .when('/dm', {
                templateUrl : 'pages/dm.html',
                controller  : 'dmController'
            })
			// route for the contact page
			.when('/contact', {
				templateUrl : 'pages/contact.html',
				controller  : 'contactController'
			});
	});

	// create the controller and inject Angular's $scope
	scotchApp.controller('mainController', function($scope) {
		// create a message to display in our view
		$scope.message = 'Everyone come and see how good I look!';
	});

	scotchApp.controller('aboutController', function($scope) {
		$scope.message = 'Look! I am an about page.';
	});

	scotchApp.controller('contactController', function($scope) {
		$scope.message = 'Contact us! JK. This is just a demo.';
	});

    scotchApp.controller('baseballController', function($scope) {
        $scope.message = 'baseball';
    });

    scotchApp.controller('dmController', function($scope) {
        $scope.message = 'dm';
    });

	scotchApp.controller('handballController', function($scope, $http) {
		$scope.message = 'HB and that';
		$scope.update = function(event) {
        		$scope.master = angular.copy(event);
		     };

        $scope.submit = function(event){

            $http.post('http://localhost:4000/state', JSON.stringify(event)).
                success(function(data, status, headers, config) {
                }).
                error(function(data, status, headers, config) {
                    alert("not worked");
                });

        }

        $scope.load = function(event){

            $http.get('http://localhost:8282/state/' + event.id).
                success(function(data, status, headers, config) {
                       $scope.event = data;
                }).
                error(function(data, status, headers, config) {
                    alert("not worked");
                });

        }
	});
