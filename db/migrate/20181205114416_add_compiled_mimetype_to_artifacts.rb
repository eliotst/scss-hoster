class AddCompiledMimetypeToArtifacts < ActiveRecord::Migration[5.1]
  def change
    add_column :artifacts, :compiled_mimetype, :string
  end
end
