window.app.controller 'AdminCtrl', ($scope, $http) ->
  console.log "sdsds"
  $scope.goStore = () ->
    window.location.href = "/admin/store"

  $scope.goCrime = () ->
    window.location.href = "/admin/crime"
