class AddFactRefToSources < ActiveRecord::Migration[5.0]
  def change
    add_reference :sources, :fact, foreign_key: true
  end
end
