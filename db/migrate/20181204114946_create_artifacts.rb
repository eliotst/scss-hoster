class CreateArtifacts < ActiveRecord::Migration[5.1]
  def change
    create_table :artifacts do |t|
      t.string :url
      t.string :mimetype
      t.text :source
      t.text :compiled

      t.timestamps
    end
  end
end
