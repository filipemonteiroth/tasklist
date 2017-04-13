require 'rails_helper'

RSpec.describe Task, type: :model do

  context "Validations" do
    it {is_expected.to validate_presence_of(:title)}
  end
  
  describe "#complete" do
    let(:task) { create(:task) }
    let(:user) { create(:user) }
    context "When task is not complete" do
      before do
        Timecop.freeze(Time.now)
        task.assign_to(user.id)
      end
      it "should mark a task as completed" do
        task.complete
        expect(task.completed?).to eq(true)
      end
      it "should set the task completed_at" do
        task.complete
        expect(task.completed_at).to eq(Time.now)
      end
    end
    context "task has no user assigned" do
      it "should not be completed if no user is assigned" do
        expect { task.complete }.to raise_error(TaskIsNotAssigned)
      end
    end
  end

  describe "#assign_to" do
    context "task is not assigned to user" do
      let(:user) { create(:user) }
      let(:task) { create(:task) }
      it "should assign task to user" do
        task.assign_to(user.id)
        expect(task.user_id).to eq(user.id)
      end
    end 
    context "task is already assigned to another user" do
      let(:user) { create(:user) }
      let(:mark) { create(:user, email: "markdye@mail.com") }
      let(:task) { create(:task, user_id: user.id) }
      it "should assign task to user" do
        expect { task.assign_to(mark.id) }.to raise_error(TaskAlreadyAssigned)
      end
    end 
  end

end
