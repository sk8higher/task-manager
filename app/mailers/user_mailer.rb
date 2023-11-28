class UserMailer < ApplicationMailer
  def task_created
    user = params[:user]
    @task = params[:task]

    mail(to: user.email, subject: 'New Task Created')
  end

  def task_updated
    user = params[:user]
    @task = params[:task]

    mail(to: user.email, subject: 'Task Was Updated')
  end

  def task_destroyed
    user = params[:user]
    @task = params[:task]

    mail(to: user.email, subject: 'Task Was Destroyed')
  end
end