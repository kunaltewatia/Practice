require 'rails_helper'

RSpec.describe 'services/index', type: :view do
  before(:each) do
    assign(:services, [
      Service.create!(
        name: 'Name',
        description: 'MyText',
        parent_id: 1,
        is_active: false
      ),
      Service.create!(
        name: 'Name',
        description: 'MyText',
        parent_id: 1,
        is_active: false
      )
    ])
  end

  it 'renders a list of services' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
