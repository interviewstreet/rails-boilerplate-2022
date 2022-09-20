class CreatePublication < ActiveRecord::Migration[7.0]
  def change
    create_table :publications do |t|
      t.string :name

      t.timestamps
    end
  end
end
