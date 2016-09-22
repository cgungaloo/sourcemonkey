class CreateFacts < ActiveRecord::Migration[5.0]
  def change
    create_table :facts do |t|
      t.string :title
      t.text :context

      t.timestamps
    end
  end
end
