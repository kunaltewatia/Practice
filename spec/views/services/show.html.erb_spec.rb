require 'rails_helper'

RSpec.describe 'services/show', type: :view do
  before(:each) do
    @service = assign(:service, Service.create!(name: 'Name',
                                                description: 'MyText',
                                                parent_id: 1,
                                                is_active: false))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
