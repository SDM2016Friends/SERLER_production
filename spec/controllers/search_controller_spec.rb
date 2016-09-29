require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  login_user

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns http success with Params" do
      get :index, params:{ "search"=>{"search_fields_attributes"=>{"0"=>{"field"=>"title", "op2"=>"ILIKE", "content"=>"how"}}},"commit"=>"Search"}
      expect(response).to have_http_status(:success)
    end

    it "renders results if parameters provided" do
      get :index, params:{ "search"=>{"search_fields_attributes"=>{"0"=>{"field"=>"title", "op2"=>"ILIKE", "content"=>"how"}}},"commit"=>"Search"}
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    let(:search) do
      Search.create!({name: "test"})
    end

    it "return http success" do
      get :show, id: search.id
      expect(response).to have_http_status(:success)
    end

    it "return the show template" do
      get :show, id: search.id
      expect(response).to render_template("show")
    end
  end

  describe "GET #history" do
    it "return http success" do
      get :history
      expect(response).to have_http_status(:success)
    end

    it "return the history template" do
      get :history
      expect(response).to render_template("history")
    end
  end

  describe "Post #Create" do
    it "create Search" do
      search_params = {
        name: "test",
        search_fields_attributes: {
          "0": {
            "field"=>"source_title", "op2"=>"ILIKE", "content"=>"Agile"
          }
        }
      }
      expect {
        post :create,
        search: search_params
      }.to change(Search, :count).by(1)
    end
  end
end
