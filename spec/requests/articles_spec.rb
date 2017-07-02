require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  after :each do
    expect(response.content_type).to eq 'application/json'
  end

  describe 'POST /articles' do
    let(:article) {{
        title: Faker::Name.title,
        content: Faker::Lorem.paragraph,
        user_ip: Faker::Internet.ip_v4_address
    }}
    let(:user) { { nickname: Faker::Internet.unique.user_name } }
    let(:expected_errors) {{
        article: ['is missing'],
        user: ['is missing']
    }}

    context 'with empty params' do
      before { post articles_path, params: { format: :json } }

      it 'return status code 422' do
        expect(response.status).to eq 422
      end

      it 'article and user are required' do
        expect(json_response).to eq expected_errors
      end
    end

    context 'with valid params' do
      before { post articles_path, params: { article: article, user: user, format: :json } }

      it 'return status code 201' do
        expect(response).to have_http_status(:created)
      end

      it 'return created article' do
        expect(json_response[:title]).to eq(article[:title])
        expect(json_response[:content]).to eq(article[:content])
      end
    end
  end

  describe 'GET /articles/top_rating' do
    let!(:articles) { create_list(:article, 20) }

    context 'get top rating articles' do
      before { get top_rating_articles_path, params: { format: :json } }

      it 'return status code 200' do
        expect(response.status).to eq 200
      end

      it 'returns all article items' do
        expect(json_response.size).to eq(20)
      end
    end
  end

  describe 'GET /articles/public_ips' do
    context 'get public ips' do
      before { get public_ips_articles_path, params: { format: :json } }

      it 'return status code 200' do
        expect(response.status).to eq 200
      end
    end
  end

end
