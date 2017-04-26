require 'rails_helper'

RSpec.describe 'localities/show', type: :view do
  before(:each) do
    @locality = assign(:locality, Locality.create!(name: 'Name', area: nil,
                                                   is_active: false))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
