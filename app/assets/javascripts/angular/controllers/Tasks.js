angular.module('taskListApp').controller('TasksCtrl', ['$scope', 'TasksService', function($scope, TasksService) {

  $scope.init = function() {
    $scope.tasks = [];
    $scope.selectedTask = {};
    TasksService.load().then(function(response) {
      $scope.tasks = response.data;
    });
  };

  $scope.add = function() {
    $("#task-modal").modal();
  };

  $scope.closeTaskModal = function() {
    $("#task-modal").modal("hide");
  };

  $scope.saveTask = function() {
    if ($scope.selectedTask.id > 0) {

    } else {
      TasksService.create($scope.selectedTask).then(function(data) {
        $scope.tasks.push(angular.copy($scope.selectedTask));
        $scope.selectedTask = {};
        $scope.closeTaskModal();
      }).catch(function(data) {
        alert(data.message);
      });
    }
  }

}]);