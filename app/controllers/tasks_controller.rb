# class TasksController < ApplicationController
# 	def new
# 		@tasks = Task.all
# 	end

# end

class TasksController < ApplicationController

	before_action :authenticate_user

	def index
    @show_all = params[:show_all]

    if @show_all == 'true'
      @add = "Here are all of your tasks." 
      @tasks = current_user.tasks.order_by(:date.asc, :priority.asc, :time.asc)
      @show_all = true
    else
      @tasks = current_user.tasks.order_by(:date.asc, :priority.asc, :time.asc)
      @show_uncompletes = true
    end
  end

  def custom
    raise params.inspect
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    # if current_user
      @task = Task.new
    # else
    #   redirect_to new_auth_path
  end

  ###### EDIT THIS PART! 
  def edit
  	@task = current_user.tasks.find(params[:id])
  end

  def create
	  @task = current_user.tasks.new(task_params)
      t=params[:task]
    @task.deadline = Time.new(t["deadline(1i)"], t["deadline(2i)"], t["deadline(3i)"], t["time(4i)"], t["time(5i)"])
    if @task.save
			redirect_to tasks_path, notice: 'Your task has been submitted. Do work, son.'
    else
      render action: 'new'
    end
  end



  def update
  	@task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Your task was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
	@task = current_user.tasks.find(params[:id])
    @task.destroy 
    @task.user.points-=@task.points
      if @user.points
		redirect_to tasks_url
  end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :priority,  :is_completed)
    end
end
