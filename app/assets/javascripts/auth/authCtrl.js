
function AuthCtrl($scope, $state, Auth) {
    $scope.login = function() {
        console.log('Getting here');
        Auth.login($scope.user).then(function(){
            $state.go('home');
        });
    };

    $scope.register = function() {
        Auth.register($scope.user).then(function(){
            $state.go('home');
        });
    };
};
angular
    .module('gremester')
    .controller("AuthCtrl", AuthCtrl);