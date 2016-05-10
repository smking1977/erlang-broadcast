
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

var id = getParameterByName('id')

    // define the module we're working with
    var app = angular.module('scoreboard', []);


	app.controller('statCtrl', ['$scope','$http', function($scope, $http) {
    	// the last received msg
       // $scope.msg = {};

        $scope.ready = function(){
            $http.get('http://localhost:8282/state/' + id).
                    success(function(data, status, headers, config) {
                        // this callback will be called asynchronously
                        //$scope.msg = data;


                        var text = data;
                        if (text.id == id){
                            $scope.msg = text;
                            $scope.msg.team1.total = text.team1.first + text.team1.second;
                            $scope.msg.team2.total = text.team2.first + text.team2.second;
                        }
                    }).
                    error(function(data, status, headers, config) {
                        // called asynchronously if an error occurs

                        $scope.msg = {
                            "id":id,
                            "sport":"handball",
                            "team1":
                            {"name":"",
                                "first":  "",
                                "second":""},
                            "team2":
                            {"name":"",
                                "first": "",
                                "second":""}
                        }
                    });
        }



        var source = new EventSource('http://localhost:8282/sse/'+id);

	 // handles the callback from the received event
        var handleCallback = function (msg) {
            $scope.$apply(function () {
		    var rawtext = msg.data.trim();
		    var text = JSON.parse(rawtext);
		    if (text.id == id){
 	               $scope.msg = text;
			$scope.msg.team1.total = text.team1.first + text.team1.second;
			$scope.msg.team2.total = text.team2.first + text.team2.second;
		}
            });
        }
        source.addEventListener('message', handleCallback, false);
    $scope.ready();

}]);
