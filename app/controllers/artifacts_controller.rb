class ArtifactsController < ApplicationController
    before_action :authenticate_user!, except: :by_path

    def index
        @artifacts = Artifact.where(user: current_user)
    end

    def new
        @artifact = Artifact.new
        @artifact.project = Project.find(params[:project_id])
    end

    def show
        @artifact = Artifact.find(params[:id])
    end

    def create
        @artifact = Artifact.new(artifact_params)
        @artifact.compile_sass
        @artifact.user = current_user

        if @artifact.save
            redirect_to @artifact
        else
            render :new, project_id: @artifact.project.id
        end
    end

    def edit
        @artifact = Artifact.find(params[:id])

        if !@artifact.can_edit(current_user)
            redirect_to artifacts
        end
    end

    def update
        @artifact = Artifact.find(params[:id])

        if !@artifact.can_edit(current_user)
            redirect_to artifacts
        end

        if @artifact.update(artifact_params)
            @artifact.user = current_user
            @artifact.compile_sass
            @artifact.save
            redirect_to @artifact
        else
            render :edit
        end
    end

    def compiled
        @artifact = Artifact.find(params[:id])
        render plain: @artifact.compiled
        response.content_type = @artifact.compiled_mimetype
    end

    def by_path
        @artifact = Artifact.match_url(params[:other])
        if @artifact.nil?
            redirect_to :artifacts
        else
            render plain: @artifact.compiled
            response.content_type = @artifact.compiled_mimetype
        end
    end

    def test
    end

    private
        def artifact_params
          params.require(:artifact).permit(:url, :mimetype, :source, :compiled, :compiled_mimetype, :project_id)
        end
end
