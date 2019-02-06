
function AuthCtrl($scope, $state, $rootScope, Auth) {
    $scope.login = function() {
        console.log('Getting here');
        var credentials = {
            email: 'admin@account.com',
            username: 'testaccount',
            password: '12345678'
        };
        Auth.login(credentials).then(function(student) {
            $scope.authError = 'Success!';
            console.log(student); // => {id: 1, ect: '...'}
            Auth.currentUser = student;
        },function(error) {
            console.log('Rejecting');
            console.log(error);
            $scope.authError = 'Authentication failed...';
        });
    };

    $scope.register = function() {
        console.log("register");
        //console.log($scope.student);
        //console.log($scope.student.config.student.email);
        Auth.register($scope.student, config).then(function (student) {
            //console.log(student);
            //console.log(student.config.student.email);
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


        //$scope.$on('devise:new-registration', function(event, user) {
            // ...
        //});
    };
};
angular
    .module('gremester')
    .controller("AuthCtrl", AuthCtrl);


