require 'rails_helper'

RSpec.describe 'localities/index', type: :view do
  before(:each) do
    assign(:localities, [
      Locality.create!(
        name: 'Name',
        area: nil,
        is_active: false
      ),
      Locality.create!(
        name: 'Name',
        area: nil,
        is_active: false
      )
    ])
  end

  it 'renders a list of localities' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
