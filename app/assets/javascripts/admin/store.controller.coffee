window.app.controller 'StoreCtrl', [
  '$scope'
  '$http'
  '$timeout'
  ($scope, $http, $timeout) ->

    $scope.selectedStore = null
    $scope.selectedStoreItems = []
    $http.get("/admin/get_store.json").then (response) ->
      console.log response.data.stores
      $scope.storeLists = response.data.stores

    $scope.AddnewStore = () ->
      $scope.newStore.lat = $('#mLat').val()
      $scope.newStore.lon = $('#mLgn').val()
      console.log $scope.newStore
      $http.post("/admin/store", $scope.newStore).then (response) ->
        console.log response
        $scope.newStore = {lat: '', lon: '', description: '', name: ''}
        # $scope.storeLists.push response.data.table.data
        # window.location.reload()

    $scope.addStoreItem = () ->
      id = $scope.selectedStore.id
      $http.post("/admin/store/#{id}/item", $scope.storeItem).then (response) ->
        console.log response
        for s in $scope.storeLists
          if s.id == id
            s.items.push response.data.table.data

    $scope.editStore = () ->
      $scope.selectedStore.lat = $('#emLat').val()
      $scope.selectedStore.lon = $('#emLgn').val()
      $http.post("/admin/store/#{$scope.selectedStore.id}/edit", $scope.selectedStore).then (response) ->
        # window.location.reload()
        
    $scope.removeItem = (id) ->
      $http.put("/admin/store/item/#{id}", {}).then (response) ->
        console.log response
        # window.location.reload()
    $scope.removeStore = (id) ->
      $http.put("/admin/store/#{id}", {}).then (response) ->
        console.log response
        # window.location.reload()

    $scope.selectStore = (store) ->
      $scope.selectedStore = store
]