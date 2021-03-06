class TasksController < ApplicationController
  #before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update, :show]


  def index
    @user = current_user
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
  end
  
  #def index
   # @tasks = Task.all.page(params[:page]).per(10)
  #end
  
  def create
#    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    		
		if @task.save
			flash[:success] = 'Taskが正常に登録されました'
			redirect_to @task
		else
			flash.now[:danger] = 'Taskが登録されませんでした'
			render :new
		end
  end

  def new
    @task = Task.new
  end
  
  def edit
    set_task
  end

  def show
    set_task
  end
  
  def update
    set_task
    
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    set_task
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end

  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end
end
