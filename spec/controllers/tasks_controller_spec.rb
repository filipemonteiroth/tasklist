require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  before do
    sign_in create(:user)
  end

  describe "GET #index" do
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
        expect(body["my_tasks"].size).to eq(0)
        expect(body["other_tasks"].size).to eq(10)
      end
    end
  end

  describe 'POST #create' do
    let(:task_params) { {title: "New task", description: "Simple task"} }
    let(:invalid_task_params) { {title: "", description: "Simple task"} }
    context "with valid attributes" do
      it "should return success" do
        post :create, task_params
        expect(response.status).to eq(200)
      end
      it "should create a task" do
        expect{post :create, task_params}.to change{Task.count }.by(1)
      end
    end
    context "without valid attributes" do
      it "should return unprocessable entity" do
        post :create, invalid_task_params
        expect(response.status).to eq(422)
      end
      it "should not create a task" do
        expect{post :create, invalid_task_params}.to change{Task.count }.by(0)
      end
    end
  end

  describe 'PUT #update' do
    let(:task) { create(:task) }
    context "with valid attributes" do
      it "should return success" do
        put :update, {id: task.id, title: "Task updated"}
        expect(response.status).to eq(200)
      end
      it "should update task" do
        put :update, {id: task.id, title: "Task updated"}
        body = JSON.parse(response.body)
        expect(body["title"]).to eq("Task updated")
      end
    end
    context "without valid attributes" do
      it "should return unprocessable entity" do
        put :update, {id: task.id, title: ""}
        expect(response.status).to eq(422)
      end
      it "should not update task" do
        put :update, {id: task.id, title: ""}
        expect(Task.first.title).to eq("My task")
      end
    end
  end

  describe 'PUT #assign_to_me' do
    let(:task) { create(:task) }
    context "task is not assigned" do
      it "should return success" do
        put :assign_to_me, {id: task.id}
        expect(response.status).to eq(200)
      end
    end
    context "task is already assigned" do
      let(:mark) { create(:user, email: "mark@mail.com")}
      it "should return error" do
        task.assign_to(mark.id)
        put :assign_to_me, {id: task.id}
        expect(response.status).to eq(500)
      end
    end
  end

  describe 'PUT #complete' do
    let(:mark) { create(:user, email: "mark@mail.com")}
    let(:task) { create(:task) }
    context "task is already assigned" do
      it "should return success" do
        task.assign_to(mark.id)
        put :complete, {id: task.id}
        expect(response.status).to eq(200)
      end
    end
    context "task is not assigned" do
      it "should return error" do
        put :complete, {id: task.id}
        expect(response.status).to eq(500)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:task) { create(:task) }
    it "should return success" do
      delete :destroy, {id: task.id}
      expect(response.status).to eq(200)
    end
  end

end