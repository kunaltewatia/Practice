require 'rails_helper'

RSpec.describe 'measurements/index', type: :view do
  before(:each) do
    assign(:measurements, [
      Measurement.create!(
        name: 'Name',
        unit: 'Unit'
      ),
      Measurement.create!(
        name: 'Name',
        unit: 'Unit'
      )
    ])
  end

  it 'renders a list of measurements' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Unit'.to_s, count: 2
  end
end
