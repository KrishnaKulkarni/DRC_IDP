require 'rails_helper'

describe GoldStandardIdentity do 

  describe "validations" do
    it { should validate_presence_of(:first_name).with_message("rempliseez cette case") }
  end
end