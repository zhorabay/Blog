class RemoveModelsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :models
  end
end
