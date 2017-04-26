require 'rails_helper'

RSpec.describe 'wings/show', type: :view do
  before(:each) do
    @wing = assign(:wing, Wing.create!(name: 'Name',
                                       society: nil,
                                       is_active: false))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
