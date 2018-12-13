class Artifact < ApplicationRecord
    belongs_to :project
    belongs_to :user

    validates :compiled_mimetype, presence: true, inclusion: { in: ['text/css'] }
    validates :mimetype, presence: true, inclusion: { in: ['text/x-scss'] }
    validates :source, presence: true, length: { minimum: 1 }
    validates :url, presence: true, length: { minimum: 2 }
    validates :user, presence: true

    def can_edit(user)
        return user.id == self.user.id
    end

    def compile_sass
        css = Sass::Engine.new(self.source, syntax: :scss)
        self.compiled = css.render
    end

    def self.match_url(path)
        path_parts = path.split("/")
        projects = Project.where(path: "/#{path_parts[0]}")
        project_ids = projects.map(&:id)
        rest = path_parts[1..-1].join("/")
        puts("project IDs: #{project_ids}, rest: #{rest}")
        Artifact.where("url = ? and project_id in (?)", rest, project_ids)[0]
    end
end
