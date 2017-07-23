window.app.controller 'AdminCtrl', [
  '$scope'
  '$http'
  '$timeout'
  ($scope, $http, $timeout) ->
    console.log "sdsds"
    $scope.goStore = () ->
      window.location.href = "/admin/store"

    $scope.goCrime = () ->
      window.location.href = "/admin/crime"
