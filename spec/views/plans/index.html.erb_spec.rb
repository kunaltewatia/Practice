require 'rails_helper'

RSpec.describe 'plans/index', type: :view do
  before(:each) do
    assign(:plans, [
      Plan.create!(
        pack: nil,
        name: 'Name',
        description: 'MyText',
        old_price: 'Old Price',
        decimal: 'Decimal',
        price: '9.99',
        days: 1,
        is_active: false
      ),
      Plan.create!(
        pack: nil,
        name: 'Name',
        description: 'MyText',
        old_price: 'Old Price',
        decimal: 'Decimal',
        price: '9.99',
        days: 1,
        is_active: false
      )
    ])
  end

  it 'renders a list of plans' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'Old Price'.to_s, count: 2
    assert_select 'tr>td', text: 'Decimal'.to_s, count: 2
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
  end
end
