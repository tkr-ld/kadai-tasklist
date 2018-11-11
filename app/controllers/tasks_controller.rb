class TasksController < ApplicationController
     before_action :require_user_logged_in
     before_action :correct_user, only: [:show, :edit, :update, :destroy]
     
    def show
        @task = Task.find(params[:id])
    end
     
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:sucsess] = 'Taskが正常に追加されました'
            redirect_to user_path(current_user)
        else
            @tasks = current_user.tasks.order('created_at DESC')
            flash.now[:danger] = 'Taskが正常に追加されませんでした'
            render 'toppages/index'
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:sucsess] = 'Taskが正常に更新されました'
            redirect_to user_path(current_user)
        else
            flash.now[:danger] = 'Taskが正常に更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        flash[:success] = 'メッセージを削除しました。'
         redirect_back(fallback_location: user_path(current_user))
    end
    
    private
        
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end