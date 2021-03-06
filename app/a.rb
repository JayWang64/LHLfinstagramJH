module TestHelper
   def humanized_time_ago(time_ago_in_minutes)
     if time_ago_in_minutes >= 60
       "#{time_ago_in_minutes / 60} hours ago"
     else
       "#{time_ago_in_minutes} minutes ago"
     end
   end
   
   def getLikeOrLikes(count)
     return "likes" if count > 1 or count == 0
     return "like" if count == 1
   end
 end