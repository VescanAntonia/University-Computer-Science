from src.domain.movie import Movie
from src.domain.client import Client
from src.domain.rental import Rental
from src.repository.repository_exception import RepositoryException


class UndoRepository:

    def __init__(self):
        self._undo_repository = []
        self._redo_repository = []

    def remove_movie(self, given_movie_id, given_movie_title, given_movie_description, given_movie_genre):
        given_movie = Movie(given_movie_id, given_movie_title, given_movie_description, given_movie_genre)
        self._undo_repository.append(['movie', 'remove', given_movie])

    def add_movie(self, movie_id, movie_title, movie_description, movie_genre):
        movie = Movie(movie_id, movie_title, movie_description, movie_genre)
        self._undo_repository.append(['movie', 'add', movie])

    def update_movie(self, movie_given_id, movie_given_title, movie_given_description, movie_given_genre):
        movie_given = Movie(movie_given_id, movie_given_title, movie_given_description, movie_given_genre)
        self._undo_repository.append(['movie', 'update', movie_given])

    def remove_client(self, client_id, client_name):
        client = Client(client_id, client_name)
        self._undo_repository.append(['client', 'remove', client])

    def add_client(self, given_client_id, given_client_name):
        given_client = Client(given_client_id, given_client_name)
        self._undo_repository.append(['client', 'add', given_client])

    def update_client(self, current_client_id, current_client_name):
        current_client = Client(current_client_id, current_client_name)
        self._undo_repository.append(['client', 'update', current_client])

    def remove_rental(self, rental_id, rented_movie_id, client_id_rental, rented_date, due_date, returned_date):
        current_rental = Rental(rental_id, rented_movie_id, client_id_rental, rented_date, due_date, returned_date)
        self._undo_repository.append(['rental', 'remove', current_rental])

    def return_movie(self, rented_movie_id):
        self._undo_repository.append(['rental', 'return', rented_movie_id])

    def undo(self, movie_service, client_service, rental_service):
        if len(self._undo_repository) == 0:
            raise RepositoryException("  There is nothing to undo!")

        current_command_to_undo_in_history_list = self._undo_repository[len(self._undo_repository) - 1]
        current_option_for_the_command_list = current_command_to_undo_in_history_list[0]
        the_command_to_be_done_for_the_undo = current_command_to_undo_in_history_list[1]
        the_element_in_list = current_command_to_undo_in_history_list[2]
        if current_option_for_the_command_list == 'movie':  # undo in movies.bin list
            if the_command_to_be_done_for_the_undo == 'remove':
                id_of_the_movie = the_element_in_list.get_movieId
                movie_service.remove_the_movie_with_given_id(id_of_the_movie)
                self._redo_repository.append(['movie', 'add', the_element_in_list])
            elif the_command_to_be_done_for_the_undo == 'add':
                movie_service.add_movie(the_element_in_list.get_movieId, the_element_in_list.get_title, the_element_in_list.get_description, the_element_in_list.get_genre)
                self._redo_repository.append(['movie', 'remove', the_element_in_list])
            else:
                movie_given_id, old_movie_title, old_movie_description, old_movie_genre = movie_service.get_data_for_updated_movie_for_undo(the_element_in_list.get_movieId)
                the_old_movie = Movie(movie_given_id, old_movie_title, old_movie_description, old_movie_genre)
                self._redo_repository.append(['movie', 'update', the_old_movie])
                movie_service.update(the_element_in_list.get_movieId, the_element_in_list.get_title, the_element_in_list.get_description, the_element_in_list.get_genre)

        elif current_option_for_the_command_list == 'client':                                               # undo in clients.bin list
            if the_command_to_be_done_for_the_undo == 'remove':
                id_of_the_client = the_element_in_list.get_client_id
                client_service.remove_the_client_with_given_id(id_of_the_client)
                self._redo_repository.append(['client', 'add', the_element_in_list])
            elif the_command_to_be_done_for_the_undo == 'add':
                client_service.add_client(the_element_in_list.get_client_id, the_element_in_list.get_name)
                self._redo_repository.append(['client', 'remove', the_element_in_list])
            else:
                old_client_id, old_client_name = client_service.find_the_client_for_given_id(the_element_in_list.get_client_id)
                the_old_client = Client(old_client_id, old_client_name)
                self._redo_repository.append(['client', 'update', the_old_client])
                client_service.update(the_element_in_list.get_client_id, the_element_in_list.get_name)
        else:
            if the_command_to_be_done_for_the_undo == 'remove':
                id_of_rental = the_element_in_list.get_rental_id
                rental_service.remove_rental(id_of_rental)
                self._redo_repository.append(['rental', 'add', the_element_in_list])
            else:
                # id_of_rented_movie = the_element_in_list.get_movie_id
                rental_service.update_unreturned_status_movie(the_element_in_list)
                self._redo_repository.append(['rental', 'update', the_element_in_list])
        self._undo_repository.pop()

    def redo(self, movie_service, client_service, rental_service):
        if len(self._redo_repository) == 0:
            raise RepositoryException("  There is nothing to redo!")

        current_command_to_redo_in_history_list = self._redo_repository[len(self._redo_repository) - 1]
        current_option_for_the_command_list = current_command_to_redo_in_history_list[0]
        the_command_to_be_done_for_the_redo = current_command_to_redo_in_history_list[1]
        the_element_in_list = current_command_to_redo_in_history_list[2]
        if current_option_for_the_command_list == 'movie':  # undo in movies.bin list
            if the_command_to_be_done_for_the_redo == 'remove':
                id_of_the_movie = the_element_in_list.get_movieId
                movie_service.remove_the_movie_with_given_id(id_of_the_movie)
                self._undo_repository.append(['movie', 'add', the_element_in_list])
            elif the_command_to_be_done_for_the_redo == 'add':
                movie_service.add_movie(the_element_in_list.get_movieId, the_element_in_list.get_title, the_element_in_list.get_description, the_element_in_list.get_genre)
                self._undo_repository.append(['movie', 'remove', the_element_in_list])
            else:
                movie_given_id, old_movie_title, old_movie_description, old_movie_genre = movie_service.get_data_for_updated_movie_for_undo(
                    the_element_in_list.get_movieId)
                the_old_movie = Movie(movie_given_id, old_movie_title, old_movie_description, old_movie_genre)
                movie_service.update(the_element_in_list.get_movieId, the_element_in_list.get_title, the_element_in_list.get_description, the_element_in_list.get_genre)
                self._undo_repository.append(['movie', 'update', the_old_movie])
        elif current_option_for_the_command_list == 'client':
            if the_command_to_be_done_for_the_redo == 'remove':
                given_id_of_the_client = the_element_in_list.get_client_id
                client_service.remove_the_client_with_given_id(given_id_of_the_client)
                self._undo_repository.append(['client', 'add', the_element_in_list])
            elif the_command_to_be_done_for_the_redo == 'add':
                client_service.add_client(the_element_in_list.get_client_id, the_element_in_list.get_name)
                self._undo_repository.append(['client', 'remove', the_element_in_list])
            else:
                old_client_id, old_client_name = client_service.find_the_client_for_given_id(
                    the_element_in_list.get_client_id)
                the_old_client = Client(old_client_id, old_client_name)
                client_service.update(the_element_in_list.get_client_id, the_element_in_list.get_name)
                self._undo_repository.append(['client', 'update', the_old_client])
        else:
            if the_command_to_be_done_for_the_redo == 'add':
                rental_service.add_rental_to_the_list(the_element_in_list.get_rental_id, the_element_in_list.get_movie_id, the_element_in_list.get_client_id, the_element_in_list.get_rented_date, the_element_in_list.get_due_date, the_element_in_list.get_returned_date)
                self._undo_repository.append(['rental', 'return', the_element_in_list])
            else:
                rental_service.update_a_movie_rented_status(the_element_in_list)
                self._undo_repository.append(['rental', 'return', the_element_in_list])
        self._redo_repository.pop()