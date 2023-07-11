import React from 'react';
import Board from '@asseinfo/react-kanban';

const data = {
  columns: [
    {
      id: 1,
      title: 'Backlog',
      cards: [
        {
          id: 1,
          title: 'Add card',
          description: 'Add capability to add a card in a column',
        },
      ],
    },
    {
      id: 2,
      title: 'Doing',
      cards: [
        {
          id: 2,
          title: 'Drap-n-drop support',
          description: 'Move a card between the columns',
        },
      ],
    },
  ],
};

function TaskBoard() {
  return <Board disableColumnDrag initialBoard={data} />;
}

export default TaskBoard;
