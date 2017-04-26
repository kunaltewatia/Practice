require 'rails_helper'

RSpec.describe 'packs/index', type: :view do
  before(:each) do
    assign(:packs, [
      Pack.create!(
        service: nil,
        name: 'Name',
        description: 'MyText',
        is_active: false
      ),
      Pack.create!(
        service: nil,
        name: 'Name',
        description: 'MyText',
        is_active: false
      )
    ])
  end

  it 'renders a list of packs' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
