require 'rails_helper'

RSpec.describe 'plan_products/show', type: :view do
  before(:each) do
    @plan_product = assign(:plan_product, PlanProduct.create!(product: nil,
                                                              package: nil,
                                                              measurement: nil,
                                                              quantity: 1))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
