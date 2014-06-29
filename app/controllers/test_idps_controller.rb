class TestIdpsController < ApplicationController
  def new
    @test_idp = TestIdp.new
    render :new
  end
  
  def create
    @test_idp = TestIdp.new(test_idp_params)

    if @test_idp.save
      flash.now[:new_record_status] = "New Test_Idp Saved Successfully!"
      @last_test_idp = @test_idp
      @test_idp = TestIdp.new
    else
      flash.now[:new_record_status] = "There was an error with your entry."
    end
    
    render :new
  end
  
  private
  def test_idp_params
    params.require(:test_idp).permit(:first_name, :last_name, :age, :sex)
  end
  
end