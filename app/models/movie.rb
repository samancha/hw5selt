class Movie < ActiveRecord::Base
  class Movie::InvalidKeyError < StandardError ; end
 
  def self.find_in_tmdb(string)
    begin
          
      matching_movies = Tmdb::Movie.find(string)
      array = []
      matching_movies.each do |movie|
        hash = { :tmdb_id => movie.id, :title => movie.title, :ratings => 'G', :release_date => movie.release_date }
        array.push(hash)
      end
      return array

    rescue NoMethodError => tmdb_gem_exception
      if Tmdb::Api.response['code'] == '401'
        raise Movie::InvalidKeyError, 'Invalid API key'
      else
        raise tmdb_gem_exception
      end
    end
  end
  
  def self.all_ratings
    %w(G PG PG-13 R)
  end

  def self.create_from_tmdb(string)
    details = Tmdb::Movie.detail(string)
    hash = {:title => details.title , :release_date => details.release_date, :rating => 'G', :description => details.overview }
    Movie.create!(hash)
  end
end