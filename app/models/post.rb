class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    has_many :likes
    
    validates_presence_of :user, :photo_url
    
    def like_count
        self.likes.size
    end
    
    def comment_count
        self.comments.size
    end
    
    def humanized_time_ago
        time_ago_in_seconds = Time.now - self.created_at
        time_ago_in_minutes = time_ago_in_seconds / 60
        time_ago_in_hours = time_ago_in_minutes / 60
        time_ago_in_days = time_ago_in_hours / 24
        time_ago_in_weeks = time_ago_in_days / 7
        time_ago_in_months = time_ago_in_weeks / 4
    
        if time_ago_in_days < 14 && time_ago_in_days>=7
            "1 week ago"
        elsif time_ago_in_days >= 14
           "#{(time_ago_in_days / 7).to_i} weeks ago"
        
        elsif time_ago_in_hours < 48 && time_ago_in_hours >=24
            "1 day ago"
        elsif time_ago_in_hours > 24
          "#{(time_ago_in_hours / 24).to_i} days ago"
        
        elsif time_ago_in_minutes == 60
            "1 day ago"
        elsif time_ago_in_minutes >= 60
          "#{(time_ago_in_minutes / 60).to_i} hours ago"
        else
          "#{time_ago_in_minutes.to_i} minutes ago"
        end
    end
    
end
