
function AuthCtrl($scope, $state, $rootScope, Auth) {
    $scope.register = function() {
        console.log("register");
        Auth.register($scope.student, config).then(function (student) {
            $rootScope.student = student
            alert("Thanks for signing up, " + student.username);
            $state.go('home');
        }, function (response) {
            alert(response.data.error)
        });
    }
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

    $scope.login = function() {
        Auth.login($scope.student, config).then(function (student) {
            $rootScope.student = student
            alert("You're signed in, " + student.username);
            $state.go('home');
        }, function (response) {
            alert(response.data.error)
        });
    };
};
angular
    .module('gremester')
    .controller("AuthCtrl", AuthCtrl);


