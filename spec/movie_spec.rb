require 'spec_helper'
require 'rails_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do
    before :each do 
      @fake = [Tmdb::Movie.new(:original_title=>"today",:release_date=>"2014-10-20", :id=>'22')]
      @id = 101
    end
    it 'should return non empty array' do
      Tmdb::Movie.stub(:find).and_return(@fake)
      result = Movie.find_in_tmdb('Aladdin')
      expect(result.length).to be > 0
    end
    context 'with valid key' do
      it 'should call Tmdb with title keywords: didnt work? ' do
        expect(Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
    end
    context 'with invalid key' do
      it 'should raise InvalidKeyError if key is missing or invalid: didnt work?' do
        allow[Tmdb::Movie].to receive(:find).and_raise(NoMethodError)
        allow[Tmdb::Api].to receive(:response).and_return({'code'=>'401'})
        expect{Movie.find_in_tmdb('Inception')}.to raise_error(Movie::InvalidKeyError)
      end
    end
    it 'should call Movie::create to add new movies by hash' do 
      Movie.create_from_tmdb(@id)
      expect(Movie.where(:id => "#{@id}").count > 0)
    end  
  end
end