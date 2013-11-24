class TasksController < ApplicationController
 
  def new
  	@task = Task.new
  	@tasks= Task.all
  end

  def create
	@task = Task.new(task_params)
	if @task.save
	# 	session[:user_id] = @user.id
		redirect_to new_task_path, notice: "thanks for the task"
	# else
	# 	render "new"
	end
  end

  def edit
  	@task = Task.find(params[:id])
  end

  def update
  	@task = Task.find(params[:id]) 
	  if @task.update(params[:task].permit(:description))
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
		params.require(:task).permit(:description)
	end


end
