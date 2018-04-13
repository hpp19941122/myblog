require 'rails_helper'
require 'spec_helper'

RSpec.describe Category, type: :model do
  describe '.search' do
    let(:params) {
      ActionController::Parameters.new()
    }

    before(:each) do
      @category = create(:category)
      create_list(:articles , 10, :title => 'test title')
      create_list(:articles , 10, :status => ArticleStatus::EDITING, :category_id => @category.id)
      create_list(:articles , 10, :status => ArticleStatus::SOLD_OUT)
      create_list(:articles , 5, :enabled => false)
    end

    it 'success' do
      rtn = Article.search_for_admin(params)
      expect(rtn).to be_success
      expect(rtn['articles'].size).to eq DEFAULT_PAGE_SIZE
      expect(rtn['total_count']).to eq 30
    end

    it 'search by title' do
      params['title'] = 'test'
      rtn = Article.search_for_admin(params)
      expect(rtn).to be_success
      expect(rtn['articles'].size).to eq 10
      expect(rtn['total_count']).to eq 10
    end

    it 'search by category' do
      params['category'] = @category.id
      rtn = Article.search_for_admin(params)
      expect(rtn).to be_success
      expect(rtn['articles'].size).to eq 10
      expect(rtn['total_count']).to eq 10
    end

    it 'search by status' do
      params['status'] = ArticleStatus::SOLD_OUT
      rtn = Article.search_for_admin(params)
      expect(rtn).to be_success
      expect(rtn['articles'].size).to eq 10
      expect(rtn['total_count']).to eq 10
    end
  end
end
