require 'rails_helper'

RSpec.describe 'wings/index', type: :view do
  before(:each) do
    assign(:wings, [
      Wing.create!(
        name: 'Name',
        society: nil,
        is_active: false
      ),
      Wing.create!(
        name: 'Name',
        society: nil,
        is_active: false
      )
    ])
  end

  it 'renders a list of wings' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
