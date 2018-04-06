class Feed < ApplicationRecord

  include ActionView::Helpers::SanitizeHelper

  def self.unread
    where(is_read: false).order('created_at DESC')
  end

  def self.read
    where(is_read: true).order('created_at DESC')
  end

  def self.all_items
    all.order('created_at DESC')
  end

  def display_title
    if title.size < 65
      return sanitize(title)
    else
      return sanitize(title[0..65]) + "..."
    end
  end

  def self.search(item)
    parts = item.split(' ')
    conditions = []
    parts.each do |part|
      conditions << "title like '%#{part}%'"
      conditions << "summary like '%#{part}%'"
      conditions << "feed_url like '%#{part}%'"
    end

    search_conditions = conditions.join(" OR ")
    @feeds=Feed.all.where(search_conditions)
  end
end
