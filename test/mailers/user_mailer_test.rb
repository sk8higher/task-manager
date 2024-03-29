require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'task created' do
    user = create(:user)
    task = create(:task)
    params = { user: user, task: task }
    email = UserMailer.with(params).task_created

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['taskmanagerdualboot@gmail.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'New Task Created', email.subject
    assert email.body.to_s.include?("Task #{task.id} was created")
  end

  test 'task updated' do
    user = create(:user)
    task = create(:task)
    params = { user: user, task: task }
    email = UserMailer.with(params).task_updated

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['taskmanagerdualboot@gmail.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'Task Was Updated', email.subject
    assert email.body.to_s.include?("Task #{task.id} was updated")
  end

  test 'task destroyed' do
    user = create(:user)
    task = create(:task)
    params = { user: user, task: task }
    email = UserMailer.with(params).task_destroyed

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['taskmanagerdualboot@gmail.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'Task Was Destroyed', email.subject
    assert email.body.to_s.include?("Task #{task.id} was destroyed")
  end
end
