class Feed < ActiveRecord::Base
  scope :unread, :conditions => ["is_read = ?", false], :order => "id DESC"
  scope :read, :conditions => ["is_read = ?", true], :order => "id DESC"
  include ActionView::Helpers::SanitizeHelper
  
  def display_title
    if title.size < 51
      return sanitize(title)
    else
      return sanitize(title[0..50]) + "..."
    end
  end
  
  def self.search(item)
    parts = item.split(' ')
    conditions = []
    parts.each do |part|
      conditions << "title like '%#{part}%'"
    end
    search_conditions = conditions.join(" OR ")
    @feeds=Feed.find(:all, :conditions => search_conditions, :order => "id DESC")
  end
  
end
