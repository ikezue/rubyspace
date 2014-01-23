require 'spec_helper'

describe HighVoltage::PagesController do
  it "routes root to #show" do
    expect(get: '/').to route_to(
      controller: 'high_voltage/pages', action: 'show', id: 'home'
    )
  end
end
