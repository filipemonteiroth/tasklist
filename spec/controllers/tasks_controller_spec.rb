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
  end

end