require 'rails_helper'

RSpec.describe 'Ratings', type: :request do
  after :each do
    expect(response.content_type).to eq 'application/json'
  end

  describe 'POST /articles/:article_id/ratings' do
    let(:expected_errors) { { rating: ['is missing'] } }
    let(:rating) { { value: 5 } }
    let(:article) { create(:article) }
    let(:average_rating) { { average_rating: rating[:value].to_f.to_s } }

    context 'with empty params' do
      before { post article_ratings_path(article_id: 1), params: { format: :json } }

      it 'return status code 422' do
        expect(response.status).to eq 422
      end

      it 'rating is required' do
        expect(json_response).to eq expected_errors
      end
    end

    context 'with valid params' do
      before { post article_ratings_path(article_id: article.id), params: { rating: rating, format: :json } }

      it 'return status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'return average rating' do
        expect(json_response).to eq average_rating
      end
    end

    context 'when article does not exist' do
      before { post article_ratings_path(article_id: 0), params: { rating: rating, format: :json } }

      it 'return status code 404' do
        expect(response.status).to eq 404
      end
    end
  end
end
