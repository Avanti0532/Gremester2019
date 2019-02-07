angular.module('gremester', ['ui.router', 'templates', 'Devise'] )
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        'AuthProvider',
        function($stateProvider, $urlRouterProvider, AuthProvider ) {
        // Set up path for Devise login, logout and signup
            AuthProvider.loginPath('/students/sign_in.json');
            AuthProvider.logoutPath('/students/sign_out.json');
            AuthProvider.resourceName('student');
            AuthProvider.registerPath('/students.json');
            $stateProvider
                .state('home', {
                    url: '/home',
                    templateUrl: 'home/_home.html',
                    controller: 'MainCtrl'
                })
                .state('login', {
                    url: '/login',
                    templateUrl: 'auth/_login.html',
                    controller: 'AuthCtrl'
                })
                .state('register', {
                    url: '/register',
                    templateUrl: 'auth/_register.html',
                    controller: 'AuthCtrl'
                });

            $urlRouterProvider.otherwise('home');
        }])
