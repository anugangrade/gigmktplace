class Attachment < ActiveRecord::Base
	belongs_to :message

	has_attached_file :file  ,
                    :url => "/assets/:class/:id/:attachment/:style.:extension",
                    :path => ":rails_root/public/assets/:class/:id/:attachment/:style.:extension"

end
