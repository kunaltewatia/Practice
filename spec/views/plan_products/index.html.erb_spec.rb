require 'rails_helper'

RSpec.describe 'plan_products/index', type: :view do
  before(:each) do
    assign(:plan_products, [
      PlanProduct.create!(
        product: nil,
        package: nil,
        measurement: nil,
        quantity: 1
      ),
      PlanProduct.create!(
        product: nil,
        package: nil,
        measurement: nil,
        quantity: 1
      )
    ])
  end

  it 'renders a list of plan_products' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 1.to_s, count: 2
  end
end
