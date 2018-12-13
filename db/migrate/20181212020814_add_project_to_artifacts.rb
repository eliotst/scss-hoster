class AddProjectToArtifacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :artifacts, :project, foreign_key: true
  end
end
