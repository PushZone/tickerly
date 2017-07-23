window.app.controller 'NavCtrl', ($scope, $http) ->
  console.log "sdsds"
  $scope.closeNav = false


  $scope.goStore = () ->
    window.location.href = "/admin/store"

  $scope.goCrime = () ->
    window.location.href = "/admin/crime"
