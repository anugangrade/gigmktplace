class ChangeExpressBooleanDatatypeInExtragigs < ActiveRecord::Migration
  def change
  	if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "mysql"
  		change_column :extragigs, :express_boolean, :boolean, default: 0
  	else
  		change_column :extragigs, :express_boolean, 'boolean USING CAST(express_boolean AS boolean)', default: 0
  	end
  end
end
