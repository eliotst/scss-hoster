class ProjectsController < ApplicationController
    before_action :authenticate_user!

    def index
        @projects = Project.where(user: current_user)
    end

    def new
        @project = Project.new
    end

    def show
        @project = Project.find(params[:id])
    end

    def create
        @project = Project.new(project_params)
        @project.user = current_user

        @project.save
        redirect_to @project
    end

    def edit
        @project = Project.find(params[:id])
    end

    def update
        @project = Project.find(params[:id])

        if @project.update(project_params)
            @project.save
            redirect_to @project
        else
            render :edit
        end
    end

    private
        def project_params
          params.require(:project).permit(:name, :path)
        end
end

