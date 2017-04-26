# SocietiesHelper
module SocietiesHelper
  def show_wings(society)
    wing_list = []
    society.wings.each do |wing|
      wing_list << wing.name
    end
    wing_list.join(',')
  end

  def locality_default
    return nil unless @society
    @society.locality_id
  end

  def area_default
    return nil unless @society && @society.locality
    @society.locality.area_id
  end
end
