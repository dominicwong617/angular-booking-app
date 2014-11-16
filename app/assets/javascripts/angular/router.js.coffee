@Guru.config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider
    .state "root",
      url: "/"
      templateUrl: "root.html"

    .state "dashboard",
      url: "/dashboard"
      templateUrl: "dashboard.html"
      resolve:
        auth: ($auth) ->
          $auth.validateUser()

    .state "dashboard.employees",
      url: "/employees"
      templateUrl: "dashboard/employees/dashboard.employees.html"
      resolve:
        auth: ($auth) ->
          $auth.validateUser()

    .state "dashboard.customers",
      url: "/customers"
      templateUrl: "dashboard/customers/dashboard.customers.html"
      resolve:
        auth: ($auth) ->
          $auth.validateUser()

    .state "dashboard.appointments",
      url: "/appointments"
      templateUrl: "dashboard/appointments/dashboard.appointments.html"
      resolve:
        auth: ($auth) ->
          $auth.validateUser()

  $urlRouterProvider.otherwise "/"
  $locationProvider.html5Mode true
