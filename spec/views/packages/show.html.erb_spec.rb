require 'rails_helper'

RSpec.describe 'packages/show', type: :view do
  before(:each) do
    @package = assign(:package, Package.create!(name: 'Name', plan: nil))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
