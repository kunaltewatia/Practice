require 'rails_helper'

RSpec.describe 'plans/show', type: :view do
  before(:each) do
    @plan = assign(:plan, Plan.create!(pack: nil, name: 'Name',
                                       description: 'MyText',
                                       old_price: 'Old Price',
                                       decimal: 'Decimal',
                                       price: '9.99',
                                       days: 1,
                                       is_active: false))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Old Price/)
    expect(rendered).to match(/Decimal/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
