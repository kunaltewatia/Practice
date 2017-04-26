require 'rails_helper'

RSpec.describe 'measurements/new', type: :view do
  before(:each) do
    assign(:measurement, Measurement.new(name: 'MyString', name: 'MyString'))
  end

  it 'renders new measurement form' do
    render

    assert_select 'form[action=?][method=?]', measurements_path, 'post' do
      assert_select 'input#measurement_name[name=?]', 'measurement[name]'

      assert_select 'input#measurement_unit[name=?]', 'measurement[unit]'
    end
  end
end
