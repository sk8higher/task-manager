class Web::BoardsController < Web::ApplicationController
  def show
    render(react_component: 'TaskBoard', props: {})
  end
end
