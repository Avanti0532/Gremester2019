angular.module('gremester')
    .controller('NavCtrl', [
        '$scope',
        'Auth',
        function($scope, Auth){
            $scope.signedIn = Auth.isAuthenticated;
            $scope.logout = Auth.logout;
            Auth.currentUser().then(function (student){
                $scope.student = student;
            });
            $scope.$on('devise:new-registration', function (e, student){
                $scope.student = student;
            });

            $scope.$on('devise:login', function (e, student){
                $scope.student = student;
            });

            $scope.$on('devise:logout', function (e, student){
                $scope.student = {};
            });

        }]);

