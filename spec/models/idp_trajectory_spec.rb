require 'rails_helper'

describe IdpTrajectory do 

  describe "factory" do
    it "should have a valid factory" do
      expect(FactoryGirl.build(:idp_trajectory)).to be_valid
    end
  end

  describe "validations" do
    it { should validate_presence_of(:stop_number).with_message("rempliseez cette case") }
    it { should validate_presence_of(:province_id).with_message("rempliseez cette case") }

    describe "of at least one of {village_id, site_id, alternate_village}" do
      subject(:idp_trajectory) { FactoryGirl.build(:idp_trajectory, attributes) }
      let(:error_messages)  { idp_trajectory.errors.messages }

      context "when all three are absent" do
        let(:attributes) { { village_id: nil, site_id: nil, alternate_village: nil } }

        it "should fail validations" do
          expect(idp_trajectory).to_not be_valid
        end

        it "should have an error message attached to each attribute" do
          idp_trajectory.save
          expect(error_messages['village_id']).to eq("must choose a village, site, or alternate_village")
          expect(error_messages['site_id']).to eq("must choose a village, site, or alternate_village")
          expect(error_messages['alternate_village']).to eq("must choose a village, site, or alternate_village")
        end
      end

      context "when village_id is present" do
        let(:attributes) { { village_id: 1, site_id: nil, alternate_village: nil } }

        it "passes validations" do
          expect(idp_trajectory).to be_valid
        end
      end

      context "when site_id is present" do
        let(:attributes) { { village_id: nil, site_id: 1, alternate_village: nil } }

        it "passes validations" do
          expect(idp_trajectory).to be_valid
        end
      end

      context "when alternate_village is present" do
        let(:attributes) { { village_id: nil, site_id: nil, alternate_village: "Goma" } }

        it "passes validations" do
          expect(idp_trajectory).to be_valid
        end
      end
    end
  end
end