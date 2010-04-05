require File.dirname(__FILE__) + '/../spec_helper'
 
describe ItemInsController do
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
    ItemIn.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    ItemIn.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(item_in_url(assigns[:item_in]))
  end
  
  it "show action should render show template" do
    get :show, :id => ItemIn.first
    response.should render_template(:show)
  end
end
