from src.repository.movieRepository import MovieRepository
from src.domain.movie import Movie


class MovieService:
    def __init__(self, movie_repository):
        self._movie_repository = movie_repository

    def add_movie(self, movie_id, movie_title, movie_description, movie_genre):
        return self._movie_repository.add_new_movie(movie_id, movie_title, movie_description, movie_genre)

    def remove_the_movie_with_given_id(self, movieID):
        return self._movie_repository.remove_movie(movieID)

    def list_movies(self):
        return self._movie_repository.display_movies()

    def update(self, movie_id, users_given_movie_title, users_given_movie_description, users_given_movie_genre):
        return self._movie_repository.update_movie(movie_id, users_given_movie_title,
                                                   users_given_movie_description, users_given_movie_genre)

    def check(self, given_id):
        return self._movie_repository.find_movie_in_movies_list(given_id)

    def generate_the_list_movies(self):
        return self._movie_repository.generate_the_movies()

    def search_for_the_id_in_the_list_of_the_movies(self, given_id_to_search):
        return self._movie_repository.search_for_the_given_id_in_movies_list(given_id_to_search)

    def search_for_given_title_movies_list(self, given_title_to_search):
        return self._movie_repository.search_the_given_title_in_movies_list(given_title_to_search)

    def search_for_given_description_movies_list(self, given_description_to_search):
        return self._movie_repository.search_the_given_title_in_movies_list(given_description_to_search)

    def search_movie_for_given_genre(self, given_word_for_genre):
        return self._movie_repository.search_for_the_given_genre_movies_list(given_word_for_genre)

    def sorted_movies_by_rented_days(self, list_with_the_sorted_days_and_ids):
        return self._movie_repository.determine_the_list_for_the_most_rented_movies(list_with_the_sorted_days_and_ids)

    def get_data_for_updated_movie_for_undo(self, id_movie):
        return self._movie_repository.get_the_data_for_movie_updated_to_undo(id_movie)
