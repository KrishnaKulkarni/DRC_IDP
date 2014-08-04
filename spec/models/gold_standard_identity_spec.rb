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

      context "when date_of_birth is present" do

      end

      context "when date_of_birth is blank"

      context "when all three of {day_, month_, year_of_birth} are present"

      context "when at least one of {day_, month_, year_of_birth} is blank"

    end
  end
end