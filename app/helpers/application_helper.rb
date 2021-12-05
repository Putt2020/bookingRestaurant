module ApplicationHelper
	def getAppointment
		@userApp = Appointment.where(user_id: session[:user_id]).where(Appointment.arel_table[:start_time].gt(DateTime.now))
	end

	def tableToRestaurant(tableID)
		#@restName = Table.find_by(tableID).restaurant.name
		@table = Table.find_by(id: tableID).restaurant.name
	end

	def allFav
		return Favorite.where(user_id: session[:user_id])
	end

	def getMaxTable
		@tabCount = Table.group(:restaurant_id).count
	end

end
