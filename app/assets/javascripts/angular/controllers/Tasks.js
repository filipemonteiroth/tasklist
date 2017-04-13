angular.module('taskListApp').controller('TasksCtrl', ['$scope', 'TasksService', function($scope, TasksService) {

  $scope.init = function() {
    $scope.tasks = [];
    TasksService.load().then(function(response) {
      $scope.tasks = response.data;
    });
  };

  $scope.newTask = function() {
    $scope.currentTask = {};
  }

  $scope.add = function() {
    $scope.newTask();
    $scope.openTaskModal();
  };

  $scope.openTaskModal = function() {
    $("#task-modal").modal();
  };

  $scope.closeTaskModal = function() {
    $("#task-modal").modal("hide");
  };

  $scope.edit = function(task) {
    $scope.editingTask = task;
    $scope.currentTask = angular.copy(task);
    $scope.openTaskModal();
  }

  $scope.saveTask = function() {
    if ($scope.currentTask.id > 0) {
      TasksService.update($scope.currentTask).then(function(data) {
        $scope.editingTask.title = $scope.currentTask.title;
        $scope.editingTask.description = $scope.currentTask.description;
        $scope.closeTaskModal();
      }).catch(function(data) {
        alert(data.message);
      });
    } else {
      TasksService.create($scope.currentTask).then(function(data) {
        $scope.tasks.push(angular.copy($scope.currentTask));
        $scope.closeTaskModal();
      }).catch(function(data) {
        alert(data.message);
      });
    }
  }

}]);