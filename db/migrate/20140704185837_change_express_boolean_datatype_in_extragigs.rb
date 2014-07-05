class ChangeExpressBooleanDatatypeInExtragigs < ActiveRecord::Migration
  def change
  	if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql2"
  		change_column :extragigs, :express_boolean, :boolean, default: 0
  	else
  		change_column :extragigs, :express_boolean, 'boolean USING CAST(express_boolean AS boolean)', default: false
  	end
  end
end
