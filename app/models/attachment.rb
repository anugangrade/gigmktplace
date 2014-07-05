class Attachment < ActiveRecord::Base
	belongs_to :message

	has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	do_not_validate_attachment_file_type :file

end
