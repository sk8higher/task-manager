import { configureStore } from '@reduxjs/toolkit';
import TasksSlice from 'slices/TaskSlice';

const store = configureStore({
  reducer: {
    TasksSlice,
  },
});

export default store;
