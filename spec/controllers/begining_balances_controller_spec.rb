require File.dirname(__FILE__) + '/../spec_helper'
 
describe BeginingBalancesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    BeginingBalance.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    BeginingBalance.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(begining_balances_url)
  end
  
  it "edit action should render edit template" do
    get :edit, :id => BeginingBalance.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    BeginingBalance.any_instance.stubs(:valid?).returns(false)
    put :update, :id => BeginingBalance.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    BeginingBalance.any_instance.stubs(:valid?).returns(true)
    put :update, :id => BeginingBalance.first
    response.should redirect_to(begining_balances_url)
  end
end
