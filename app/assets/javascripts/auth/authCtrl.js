
function AuthCtrl($scope, $state, Auth) {
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
        var credentials = {
            email: 'user@domain.com2',
            username: 'test2',
            first_name: 'linh',
            last_name: 'pham',
            password: 'password1',
            password_confirmation: 'password1'
        };
        var config = {
            headers: {
                'X-HTTP-Method-Override': 'POST'
            }
        };

        Auth.register(credentials, config).then(function(registeredUser) {
            console.log(registeredUser); // => {id: 1, ect: '...'}
        }, function(error) {
           console.log('registration failed');
        });

        $scope.$on('devise:new-registration', function(event, user) {
            // ...
        });
    };
};
angular
    .module('gremester')
    .controller("AuthCtrl", AuthCtrl);


