// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require angular-devise

angular.module('myModule', ['Devise']).
config(function(AuthProvider) {
    // Configure Auth service with AuthProvider
}).
controller('myCtrl', function(Auth) {
    // Use your configured Auth service.
});

var app = angular.module('gremester', ['ui.router', 'templates', 'Devise'])
    .config([
        '$stateProvider',
        '$urlRouterProvider',
        function($stateProvider, $urlRouterProvider){
            $stateProvider
                .state('home', {
                    url: '/home',
                    templateUrl: 'home/_home.html',
                    controller: 'MainCtrl',
                    resolve: {
                        projectPromise: ['projects', function(projects) {
                            console.log($rootScope);
                            return projects.getAll();
                        }]
                    }
                })
                .state('projects', {
                    url: '/projects/{id}',
                    templateUrl: 'projects/_projects.html',
                    controller: 'ProjectsCtrl',
                    resolve: {
                        project: ['$stateParams', 'projects', function($stateParams, projects) {
                            return projects.get($stateParams.id);
                        }]
                    }
                })
                .state('login', {
                    url: '/login',
                    templateUrl: 'auth/_login.html',
                    controller: 'AuthCtrl',
                    onEnter: ['$state', 'Auth', function($state, Auth) {
                        Auth.currentUser().then(function() {
                            $state.go('home');
                        })
                    }]
                })
                .state('register', {
                    url: '/register',
                    templateUrl: 'auth/_register.html',
                    controller: 'AuthCtrl',
                    onEnter: ['$state', 'Auth', function($state, Auth) {
                        Auth.currentUser().then(function() {
                            $state.go('home');
                        })
                    }]
                });

            $urlRouterProvider.otherwise('home');
        }
    ]);
// run blocks
app.run(function($rootScope, Auth) {
    // you can inject any instance here
    $rootScope.$on('$stateChangeStart',
        function(event, toState, toParams, fromState, fromParams){
            if(!Auth.isAuthenticated()) {
                // So the magic should probably happen here. But how do I implement this?
                // And how do I allow users to access the /login and /register page?
                event.preventDefault();
            }
        })
});