require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  describe "GET #index" do
    before do
      sign_in create(:user)
    end
    context "format is html" do
      it "should render the index html" do
        get :index, format: :html
        expect(response).to render_template(:index)
      end
    end

    context "format is json" do
      before do
        FactoryGirl.create_list(:task, 10)
      end
      it "should render all tasks with possible assigned users" do
        get :index, format: :json
        body = JSON.parse(response.body)
        expect(response.status).to eq(200)
        expect(body.count).to eq(10)
      end
    end
  end

end