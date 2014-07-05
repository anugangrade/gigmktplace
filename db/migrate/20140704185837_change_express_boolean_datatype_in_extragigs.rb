class ChangeExpressBooleanDatatypeInExtragigs < ActiveRecord::Migration
  def change
  	change_column :extragigs, :express_boolean, :boolean, default: 0
  end
end
