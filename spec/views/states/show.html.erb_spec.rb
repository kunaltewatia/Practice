require 'rails_helper'

RSpec.describe 'states/show', type: :view do
  before(:each) do
    @state = assign(:state, State.create!(name: 'Name', country: nil))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
