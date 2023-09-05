import PropTypes from 'prop-types';
import PropTypesPresenter from 'utils/PropTypesPresenter';

import UserPresenter from './UserPresenter';

export default new PropTypesPresenter(
  {
    id: PropTypes.number,
    name: PropTypes.string,
    description: PropTypes.string,
    author: UserPresenter.shape(),
    assignee: UserPresenter.shape(),
    state: PropTypes.string,
    transitions: PropTypes.array,
  },
  {
    taskName(task) {
      return `${this.name(task)}`;
    },

    taskDescription(task) {
      return `${this.description(task)}`;
    },

    taskAuthor(task) {
      return this.author(task);
    },

    taskAssignee(task) {
      return this.assignee(task);
    },

    taskState(task) {
      return `${this.state(task)}`;
    },

    taskTransitions(task) {
      return this.transitions(task);
    },
  },
);

export const STATES = [
  { key: 'new_task', value: 'New' },
  { key: 'in_development', value: 'In Dev' },
  { key: 'in_qa', value: 'In QA' },
  { key: 'in_code_review', value: 'In CR' },
  { key: 'ready_for_release', value: 'Ready for release' },
  { key: 'released', value: 'Released' },
  { key: 'archived', value: 'Archived' },
];
