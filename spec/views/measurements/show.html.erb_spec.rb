require 'rails_helper'

RSpec.describe 'measurements/show', type: :view do
  before(:each) do
    @measurement = assign(:measurement, Measurement.create!(name: 'Name',
                                                            unit: 'Unit'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Unit/)
  end
end
