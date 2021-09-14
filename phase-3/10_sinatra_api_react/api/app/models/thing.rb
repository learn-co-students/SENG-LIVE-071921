class Thing < ActiveRecord::Base
  belongs_to :spot

  def spot_name=(spot_name)
    self.spot = Spot.find_or_create_by(name: spot_name)
  end

  def spot_name
    spot.try(:name)
  end
end