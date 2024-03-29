class SendTaskDestroyNotificationJob < MailerJob
  def perform(task_id)
    task = Task.find_by(id: task_id)
    return if task.blank?

    UserMailer.with(user: task.author, task: task).task_destroyed.deliver_now
  end
end
