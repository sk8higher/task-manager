class Web::DevelopersController < Web::ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(developer_params)

    if @developer.save
      sign_in(@developer)
      redirect_to(:board)
    else
      render(:new)
    end
  end

  private

  def developer_params
    params.require(:developer).permit(:first_name, :last_name, :password, :email, :password_confirmation)
  end
end
