require 'rails_helper'

RSpec.describe 'measurements/edit', type: :view do
  before(:each) do
    @measurement = assign(:measurement, Measurement.create!(name: 'MyString',
                                                            unit: 'MyString'))
  end

  it 'renders the edit measurement form' do
    render

    assert_select 'form[action=?][method=?]',
                  measurement_path(@measurement), 'post' do
      assert_select 'input#measurement_name[name=?]', 'measurement[name]'

      assert_select 'input#measurement_unit[name=?]', 'measurement[unit]'
    end
  end
end
