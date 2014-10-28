require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
    it 'should call the model method that performs TMDb search' do
      fake_results=[double('movie1'),double('movie2')]
      expect(Movie).to receive(:find_in_tmdb).with('Ted').and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
    end
    it 'should make the TMDb search results available to that template' do
      fake_results=[double('movie1'),double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results)
      post :search_tmdb, {:search_terms => 'hardware'}
      expect(assigns(:movies)) == fake_results
    end
    it 'should check to see if the search term is nil' do
      fake_results= nil
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results)
      post :search_tmdb, {:search_terms => ''}
      expect(assigns(:movies)) == fake_results
    end
  end

  describe 'add Tmdb' do
    it 'should check to see if no checked bokes are checked' do
      allow(Movie).to receive(:find_in_tmdb).and_return(nil)
      post :add_tmdb, {:search_terms => ''}
      expect(assigns(:movies)) == nil
    end
    it 'check to see if a box was checked and redirect_to movies path' do
      allow(Movie).to receive(:create_from_tmdb)
      post :add_tmdb, {:tmdb_movies => {"Aladdin" => "1"}}
      expect(response).to redirect_to(movies_path)
    end
  end
end