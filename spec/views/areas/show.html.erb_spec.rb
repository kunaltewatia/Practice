require 'rails_helper'

RSpec.describe 'areas/show', type: :view do
  before(:each) do
    @area = assign(:area, Area.create!(name: 'Name', city: nil,
                                       is_active: false))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
