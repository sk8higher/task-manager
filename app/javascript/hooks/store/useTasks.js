import { useSelector } from 'react-redux';
import { useTasksActions } from 'slices/TasksSlice';
import TaskPresenter, { STATES } from 'presenters/TaskPresenter';
import TaskForm from 'forms/TaskForm';

const useTasks = () => {
  const { loadColumn, loadColumnMore, createTask, updateTask, destroyTask, reloadCard, handleCardLoad } = useTasksActions();

  const board = useSelector((state) => state.TasksSlice.board);
  const loadBoard = () => STATES.map(({ key }) => loadColumn(key));

  const createNewTask = (params, handleClose) => {
    const attributes = TaskForm.attributesToSubmit(params);

    return createTask(attributes).then(({ data: { task } }) => {
      loadColumn(TaskPresenter.taskState(task));
      handleClose();
    });
  };

  const removeTask = (task, handleClose) => {
    destroyTask(task.id).then(() => {
      loadColumn(TaskPresenter.taskState(task));
      handleClose();
    });
  };

  const changeTask = (task, handleClose) => {
    const attributes = TaskForm.attributesToSubmit(task);

    return updateTask(task.id, attributes).then(() => {
      loadColumn(TaskPresenter.taskState(task));
      handleClose();
    });
  };

  const moveCard = (task, source, destination) => {
    const transition = TaskPresenter.taskTransitions(task).find(({ to }) => destination.toColumnId === to);
    if (!transition) {
      return null;
    }

    return reloadCard(task.id, { stateEvent: transition.event })
      .then(() => {
        loadColumn(destination.toColumnId);
        loadColumn(source.fromColumnId);
      })
      .catch((error) => {
        alert(`Move failed! ${error.message}`); // eslint-disable-line no-alert
      });
  };

  const loadTask = (id) => handleCardLoad(id);

  return {
    board,
    loadBoard,
    loadColumn,
    loadColumnMore,
    createNewTask,
    removeTask,
    changeTask,
    moveCard,
    loadTask,
  };
};

export default useTasks;
