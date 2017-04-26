require 'rails_helper'

RSpec.describe 'packs/show', type: :view do
  before(:each) do
    @pack = assign(:pack, Pack.create!(service: nil, name: 'Name',
                                       description: 'MyText', is_active: false))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
  end
end
