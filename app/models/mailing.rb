class Mailing < ActiveRecord::Base
  belongs_to :feed
  validates_presence_of :message_subject, :message_body
  
end
