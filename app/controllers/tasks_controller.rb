class TasksController < ApplicationController
 
  def new
  	@task = Task.new
  	@tasks= current_user.tasks
  end

  def create
	@task = current_user.tasks.new(task_params)
	if @task.save
		redirect_to new_task_path, notice: "thanks for the task"
	else
		render "new"
	end
  end

  def edit
  	@task = Task.find(params[:id])
  end

  def update
  	@task = Task.find(params[:id])
        @tasks = Task.find(params[:id])
	  if @task.update(params[:task].permit(:description, :category_id))
	    redirect_to new_task_path
	  else
	    render 'edit'
	  end
  end


  def destroy
  	@task = Task.find(params[:id])
  	@task.destroy
  	redirect_to new_task_path
  end


private

	def task_params
		params.require(:task).permit(:description, :user_id, :category_id)
	end


end
