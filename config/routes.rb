Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  match 'movies/search_tmdb', to: 'movies#search_tmdb'
  match 'movies/add_tmdb', to: 'movies#add_tmdb'
end
