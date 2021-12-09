module ApplicationHelper
	def getAppointment
		@userApp = Appointment.where(user_id: session[:user_id]).where(Appointment.arel_table[:start_time].gt(DateTime.now)).order("start_time ASC")
	end

	def tableToRestaurant(tableID)
		#@restName = Table.find_by(tableID).restaurant.name
		@table = Table.find_by(id: tableID).restaurant.name
	end

	def allFav # for current user
		return Favorite.where(user_id: session[:user_id])
	end

	def getMaxTable
		@tabCount = Table.group(:restaurant_id).count
		@tabCount.default = 0
	end

	def allRest
		return Restaurant.all
	end

	def restRate #every restaurant average rate score
		@resRate = Rate.group(:restaurant_id).average(:rate_score)
		@resRate.default = 0
	end

	def allComment(restID) # for specific restaurant
		return Comment.where(restaurant_id: restID).order("created_at DESC")
	end

	def didUserFav(restID) # if user has this restaurant in favorite list
		@favo = Favorite.find_by(user_id: session[:user_id], restaurant_id: restID)
		return @favo.nil?
	end

	def didUserLike(commentID) #did user like or dislike the comment
		liked = Like.find_by(user_id: session[:user_id], comment_id: commentID)
		
		if liked.nil? # user did not like or dislike this comment
			@likeState = 0
		elsif liked.like_tag # user like this comment
			@likeState = 1
		else # user dislike this comment
			@likeState = 2
		end
		return @likeState
	end

	def getLikeAndDislike(commentID) #get total like and dislike for a specific comment
		@likeCount = Like.where(comment_id: commentID).group(:like_tag).count
		@likeCount.default = 0
	end

	def getAllTableInRest(restID) #get all tables belong to a restaurant
		return Table.where(restaurant_id: restID)
	end

	def getAvailableTime(tableID) #is this table available at each specific time
		avaiTime = Appointment.where(table_id: tableID).where('start_time >= ?', Date.today).pluck("start_time")
		@at10 = avaiTime.include? Date.today.to_s.concat(" 10:00").to_datetime
		@at12 = avaiTime.include? Date.today.to_s.concat(" 12:00").to_datetime
		@at14 = avaiTime.include? Date.today.to_s.concat(" 14:00").to_datetime
		@at16 = avaiTime.include? Date.today.to_s.concat(" 16:00").to_datetime
		@at18 = avaiTime.include? Date.today.to_s.concat(" 18:00").to_datetime
		@at20 = avaiTime.include? Date.today.to_s.concat(" 20:00").to_datetime
	end

	def getTableRange(restID) #for dropdown table number in Appointment
		t = Table.where(restaurant_id: restID).maximum("table_number")
		@appointable = true
		@r = 1..t
		if t.nil?
			@r = 0..0
			@appointable = false
		end
	end
end
