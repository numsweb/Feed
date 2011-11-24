class Feed < ActiveRecord::Base
  scope :unread, :conditions => ["is_read = ?", false]
  scope :read, :conditions => ["is_read = ?", true]
  
  def display_title
    if title.size < 51
      return title
    else
      return title[0..50] + "..."
    end
  end
  
end
