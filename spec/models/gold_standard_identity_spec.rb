require 'rails_helper'

describe GoldStandardIdentity do 

  describe "factory" do
    it "should have a valid factory" do
      expect(FactoryGirl.build(:gold_standard_identity)).to be_valid
    end
  end

  describe "validations" do
    it { should validate_presence_of(:first_name).with_message("rempliseez cette case") }
    it { should validate_presence_of(:year_of_birth).with_message("rempliseez cette case") }
    it { should_not validate_presence_of(:month_of_birth) }
    it { should_not validate_presence_of(:day_of_birth) }
    it { should_not validate_presence_of(:date_of_birth) }
  end

  describe "callbacks" do
    describe "sanitizing blank strings" do
      it "converts blank-string attributes to nil just before validations are run" 
    end

    describe "synchronizing date_of_birth with with day_, month_, and year_of_birth" do
      let!(:database_identity) { FactoryGirl.create(:gold_standard_identity, date_of_birth: dob) }
      let(:new_identity) do 
        FactoryGirl.build(:gold_standard_identity, first_name: "Joseph", day_of_birth: day,
         month_of_birth: month, year_of_birth: year) 
      end

      context "when date_of_birth is present" do
        let(:dob) { Date.new(1990, 5, 19) }

        it "assigns day_, month_, and year_of_birth appropriately upon initializing a found GoldStandardIdentity" do
          found_identity = GoldStandardIdentity.last
          expect(found_identity.year_of_birth).to eq(1990)
          expect(found_identity.month_of_birth).to eq(5)
          expect(found_identity.day_of_birth).to eq(19)
        end
      end

      context "when date_of_birth is blank" do
        let(:dob) { nil }

        it "leaves day_, month_, and year_of_birth untouched" do
          found_identity = GoldStandardIdentity.last
          expect(found_identity.year_of_birth).to eq(1989)
          expect(found_identity.month_of_birth).to be_nil
          expect(found_identity.day_of_birth).to be_nil
        end
      end

      context "when all three of {day_, month_, year_of_birth} are present" do
        let(:day) { 19 }
        let(:month) { 5 }
        let(:year) { 1990 }

        it "assigns date_of_birth appropriately before saving" do
          new_identity.save
          found_identity = GoldStandardIdentity.find_by(first_name: "Joseph")
          expect(found_identity.date_of_birth).to eq(Date.new(1990, 5, 19))
        end
      end

      context "when at least one of {day_, month_, year_of_birth} is blank" do
        let(:day) { 19 }
        let(:month) { nil }
        let(:year) { 1990 }

        it "leaves date_of_birth untouched" do
          new_identity.save
          found_identity = GoldStandardIdentity.find_by(first_name: "Joseph")
          expect(found_identity.date_of_birth).to be_nil
        end
      end

    end
  end
end