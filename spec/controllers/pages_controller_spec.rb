require 'spec_helper'

describe HighVoltage::PagesController, '#show' do
  describe "GET about" do
    it "responds successfully with HTTP 200 status code" do
      get :show, id: 'about'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the about template" do
      get :show, id: 'about'
      expect(response).to render_template('about')
    end
  end

  describe "GET contact" do
    it "responds successfully with HTTP 200 status code" do
      get :show, id: 'contact'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the contact template" do
      get :show, id: 'contact'
      expect(response).to render_template('contact')
    end
  end

  describe "GET home" do
    it "responds successfully with HTTP 200 status code" do
      get :show, id: 'home'
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the about template" do
      get :show, id: 'home'
      expect(response).to render_template('home')
    end
  end
end
