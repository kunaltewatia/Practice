require 'rails_helper'

RSpec.describe 'societies/index', type: :view do
  before(:each) do
    assign(:societies, [
      Society.create!(
        name: 'Name',
        locality: nil,
        latitude: 'Latitude',
        longlatitude: 'Longlatitude',
        is_active: false
      ),
      Society.create!(
        name: 'Name',
        locality: nil,
        latitude: 'Latitude',
        longlatitude: 'Longlatitude',
        is_active: false
      )
    ])
  end

  it 'renders a list of societies' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'Latitude'.to_s, count: 2
    assert_select 'tr>td', text: 'Longlatitude'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
