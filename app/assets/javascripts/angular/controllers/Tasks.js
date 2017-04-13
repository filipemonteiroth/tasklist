angular.module('taskListApp').controller('TasksCtrl', ['$scope', 'TasksService', function($scope, TasksService) {

  $scope.init = function() {
    $scope.tasks = [];
    TasksService.load().then(function(response) {
      $scope.myTasks = response.data.my_tasks;
      $scope.otherTasks = response.data.other_tasks;
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
  };

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
  };

  $scope.assingToMe = function(task, index) {
    $scope.otherTasks.splice(index, 1);
    $scope.myTasks.push(task);
    TasksService.assignToMe(task);
  };

  $scope.complete = function(task) {
    task.completed = true;
    TasksService.complete(task);
  };

  $scope.delete = function(tasksList, task, index) {
    if (confirm("Are you sure you want do delete?")) {
      tasksList.splice(index, 1);
      TasksService.delete(task);
    }
  };

}]);