class GroupIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :user_group

  def user_group
    current_user.user_groups.find_by(group_id: object.id)
  end
end
