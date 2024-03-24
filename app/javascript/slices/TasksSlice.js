import { propEq } from 'ramda';
import { createSlice } from '@reduxjs/toolkit';
import TasksRepository from 'repositories/TasksRepository';
import { STATES } from 'presenters/TaskPresenter';
import { useDispatch } from 'react-redux';
import { changeColumn } from '@asseinfo/react-kanban';

const initialState = {
  board: {
    columns: STATES.map((column) => ({
      id: column.key,
      title: column.value,
      cards: [],
      meta: {},
    })),
  },
};

const tasksSlice = createSlice({
  name: 'tasks',
  initialState,
  reducers: {
    loadColumnSuccess(state, { payload }) {
      const { items, meta, columnId } = payload;
      const column = state.board.columns.find(propEq(columnId, 'id'));

      state.board = changeColumn(state.board, column, {
        cards: items,
        meta,
      });

      return state;
    },

    loadColumnMoreSuccess(state, { payload }) {
      const { items, meta, columnId } = payload;
      const column = state.board.columns.find(propEq('id', columnId));

      state.board = changeColumn(state.board, column, {
        cards: [...column.cards, ...items],
        meta,
      });

      return state;
    },
  },
});

export const { loadColumnSuccess, loadColumnMoreSuccess } = tasksSlice.actions;

export default tasksSlice.reducer;

export const useTasksActions = () => {
  const dispatch = useDispatch();

  const loadColumn = (state, page = 1, perPage = 10) =>
    TasksRepository.index({
      q: { stateEq: state, s: 'id DESC' },
      page,
      perPage,
    }).then(({ data }) => {
      dispatch(loadColumnSuccess({ ...data, columnId: state }));
    });

  const loadColumnMore = (state, page = 1, perPage = 10) =>
    TasksRepository.index({
      q: { stateEq: state, s: 'id DESC' },
      page,
      perPage,
    }).then(({ data }) => {
      dispatch(loadColumnMoreSuccess({ ...data, columnId: state }));
    });

  const createTask = (attributes) => TasksRepository.create(attributes);
  const destroyTask = (id) => TasksRepository.destroy(id);
  const updateTask = (id, attributes) => TasksRepository.update(id, attributes);
  const reloadCard = (id, stateEvent) => TasksRepository.update(id, stateEvent);
  const handleCardLoad = (id) => TasksRepository.show(id).then(({ data: { task } }) => task);
  const attachTaskImage = (attachmentParams) => TasksRepository.attachImage(attachmentParams);
  const removeTaskImage = (id) => TasksRepository.removeImage(id);

  return {
    loadColumn,
    loadColumnMore,
    destroyTask,
    updateTask,
    createTask,
    reloadCard,
    handleCardLoad,
    attachTaskImage,
    removeTaskImage,
  };
};
