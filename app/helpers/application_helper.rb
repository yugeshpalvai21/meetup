module ApplicationHelper
	def find_group_organizers(group)
		organizers = group.group_users.where('role = ?', 'organizer')
		if organizers.empty?
			return "No Organizer"
		else
			organizers_list = []
			organizers.each do |organizer|
				organizers_list << organizer.user.full_name
			end
			return organizers_list.join(',')
		end
	end
end
