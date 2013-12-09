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
	  if @task.update(params[:task].permit(:description, :path_id))
	    redirect_to new_task_path
	  else
	    render 'edit'
	  end
  end


  def update_multiple
    Task.update(params[:tasks].keys, params[:tasks].values)
    redirect_to new_task_path
  end


  def destroy
  	@task = Task.find(params[:id])
  	@task.destroy
  	redirect_to new_task_path
  end

  def categorize
    @tasks= current_user.tasks.where("path_id = ? AND category_id is null", '1')
  end

  def categorize_multiple
    Task.update(params[:tasks].keys, params[:tasks].values)
    redirect_to categorize_tasks_path
  end

  def project
    @task = Task.new
    @tasks= current_user.tasks.where("path_id = ? AND category_id = ?", '1', '2')
  end


  def later
    @task = Task.new
    @tasks= current_user.tasks.where("path_id = ? OR category_id = ?", '2', '3')
  end

  def finish
    @tasks = current_user.tasks.where("category_id = ? AND completed_at is null", '1' )
    @complete_tasks = current_user.tasks.where("category_id = ? AND completed_at is not null", '1' )
  end

  def complete
    Task.update_all(["completed_at=?", Time.now], :id => params[:task_ids])
    redirect_to finish_tasks_path
  end

  def list
   @tasks = current_user.tasks
  end


private

	def task_params
		params.require(:task).permit(:description, :user_id, :path_id, :category_id)
	end


end
