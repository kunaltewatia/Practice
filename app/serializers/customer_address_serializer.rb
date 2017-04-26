# Serializer for address belongs to customer detail
class CustomerAddressSerializer < ActiveModel::Serializer
  attributes :id, :country, :state, :city, :area, :locality, :society, :wing,
             :flat_no

  def country
    object.country.name
  end

  def state
    object.state.name
  end

  def city
    object.city.name
  end

  def area
    object.area.name
  end

  def locality
    object.locality.name
  end

  def society
    object.society.name
  end

  def wing
    object.wing.name
  end
end
