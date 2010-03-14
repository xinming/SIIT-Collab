class DashboardController < ApplicationController
  before_filter :require_user, :set_title

  def user_home
    @groups = current_user.groups
    group_ids = @groups.collect { |g| g.id }
    @shares = Share.all(:conditions => { :group_id => group_ids}, :order => "created_at DESC" )
    @news = Share.all(:conditions => { :content_type => "News", :group_id => group_ids}, :order => "created_at DESC")
    @news_by_day = @news.group_by { |n|
      created_at = n.created_at.at_beginning_of_day
      yesterday = Time.now.yesterday.at_beginning_of_day
      if created_at.today?
        "Today"
      elsif created_at == yesterday
        "Yesterday"
      else
        n.created_at.strftime('%d %B %Y')
      end
    }
    @right = render_to_string :partial => "right"
  end

private
  def set_title
    @title = "Dashboard"
  end
end

