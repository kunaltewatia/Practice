require 'rails_helper'

RSpec.describe 'societies/show', type: :view do
  before(:each) do
    @society = assign(:society, Society.create!(name: 'Name',
                                                locality: nil,
                                                latitude: 'Latitude',
                                                longlatitude: 'Longlatitude',
                                                is_active: false))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Latitude/)
    expect(rendered).to match(/Longlatitude/)
    expect(rendered).to match(/false/)
  end
end
