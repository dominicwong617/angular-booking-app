@Guru = angular.module("Guru", [
  "ngCookies"
  "ng-token-auth"
  "ui.router"
  "pascalprecht.translate"
  "templates"
  "ng-rails-csrf"
  "localytics.directives"
  "angular-datepicker"
  "smart-table"
])


@Guru.config ($authProvider) ->
  # TODO: The apiUrl should depend on the environment.
  $authProvider.configure(apiUrl: "http://localhost:3000")

