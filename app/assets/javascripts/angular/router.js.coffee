@Guru.config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider
    .state "root",
      url: "/"
      templateUrl: "landing.html"

    .state "dashboard",
      url: "/dashboard"
      templateUrl: "dashboard.html"

  $urlRouterProvider.otherwise "/"
  $locationProvider.html5Mode true
