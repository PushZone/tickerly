window.app.controller 'CrimeCtrl', [
  '$scope'
  '$http'
  '$timeout'
  ($scope, $http, $timeout) ->

    $scope.selectedStore = null
    $scope.selectedStoreItems = []
    console.log "CrimeCtrl"
    $http.get("/admin/get_crime.json").then (response) ->
      console.log response
      $scope.crimeLists = response.data.crimes

    $scope.goAdmin = () ->
      # window.location.href = "/admin"

    $scope.addCrime = () ->
      $scope.newCrime.lat = $('#mLat').val()
      $scope.newCrime.lon = $('#mLgn').val()
      $scope.newCrime.location = $('#locationName').val()
      $http.post("/admin/crime", $scope.newCrime).then (response) ->
        console.log response
        # $scope.newStore = {lat: '', lon: '', description: '', name: ''}
        $scope.crimeLists.push response.data.table.data

    $scope.removeCrime = (id, index) ->
      $http.put("/admin/crime/#{id}", {}).then (response) ->
        $scope.crimeLists.splice(index, 1)

    $scope.selectStore = (store) ->
      $scope.selectedStore = store

]