window.app.controller 'NavCtrl', [
  '$scope'
  '$http'
  '$timeout'
  ($scope, $http, $timeout) ->
    $scope.closeNav = false


    $scope.goStore = () ->
      window.location.href = "/admin/store"

    $scope.goCrime = () ->
      window.location.href = "/admin/crime"

]