@Guru.controller "CreateEmployeesController", [
  "$scope"
  "$auth"
  "EmployeesService"
  ($scope, $auth, EmployeesService) ->

    $scope.roles = ["admin", "manager", "staff"]

    $scope.submitRegistration = ->
      $scope.registrationForm.company_id = $scope.currentUser().company_id
      EmployeesService.createEmployee($scope.registrationForm).then (resp) ->
        $("#add-employee-form").modal "hide"
        $scope.registrationForm = {}
        $scope.alertSuccess "SESSION.EMPLOYEE_ADDED"
        $scope.$emit "employee-created", resp.data.data
      .catch (err) ->
        $scope.alertDanger "USER.INVALID_DATA"

  ]

