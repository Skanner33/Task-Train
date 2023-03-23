class TodosController < ApplicationController
  before_action :session_expired?
  rescue_from ArgumentError, with: :invalid_priority

  def create
    todo = user.todos.create(todo_params)
    if todo.valid?
      app_response(status: :created, data: todo)
    else
      app_response(status: :unprocessable_entity, data: todo.errors, message: "failed")
    end
  end

  def update
    todo = user.todos.find(params[:id]).update(todo_params)
    if todo
      app_response(data: { info: 'updated todo successfully' })
    else
      app_response(message: 'failed', data: { info: "somethimg went wrong could not update todo" })
    end
  end

  def invalid_priority
    app_response(message: "failed", data: { info: "invalid priority" }, status: :unprocessable_entity)
  end

  private

  def todo_params
    params.permit(:title, :description, :status, :priority)
  end
end
