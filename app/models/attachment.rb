class Attachment < ActiveRecord::Base
	belongs_to :message
	belongs_to :order_message

	has_attached_file :file  ,
                    :url => "/assets/:class/:id/:attachment/:style.:extension",
                    :path => ":rails_root/public/assets/:class/:id/:attachment/:style.:extension"
    do_not_validate_attachment_file_type :file
end
