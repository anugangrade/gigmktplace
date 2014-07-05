class CreateExtragigs < ActiveRecord::Migration
  def change
    create_table :extragigs do |t|
      t.string :title
      t.string :amount_per_extragig
      t.string :express_boolean

      t.timestamps
    end
  end
end
