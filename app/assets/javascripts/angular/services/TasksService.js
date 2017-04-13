angular.module('taskListApp').service('TasksService', ['$http', function($http) {

  var tasksService = {};

  tasksService.load = function() {
    return $http({method: 'get', url: '/tasks.json'});
  };

  tasksService.create = function(task) {
    return $http({method: 'post', url: '/tasks.json', data: task});
  };

  return tasksService;

}]);