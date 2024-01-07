class TotalTasksModel {
  int totalTasks;
  int totalTasksFinish;

  TotalTasksModel({
    required this.totalTasks,
    required this.totalTasksFinish,
  });

  get totalOpen => totalTasks - totalTasksFinish;
}
