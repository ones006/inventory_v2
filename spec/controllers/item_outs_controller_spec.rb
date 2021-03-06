require File.dirname(__FILE__) + '/../spec_helper'
 
describe ItemOutsController do
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
    ItemOut.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ItemOut.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(item_out_url(assigns[:item_out]))
  end
  
  it "show action should render show template" do
    get :show, :id => ItemOut.first
    response.should render_template(:show)
  end
end
