class UndoService:
    def __init__(self, undo_repository, movie_service, client_service, rental_service):
        self._undo_repository = undo_repository
        self._movie_service = movie_service
        self._client_service = client_service
        self._rental_service = rental_service

    def remove_movie(self, given_movie_id, given_movie_title, given_movie_description, given_movie_genre):
        return self._undo_repository.remove_movie(given_movie_id, given_movie_title, given_movie_description, given_movie_genre)

    def add_movie(self, givenMovie_id, givenMovie_title, givenMovie_description, givenMovie_genre):
        self._undo_repository.add_movie(givenMovie_id, givenMovie_title, givenMovie_description, givenMovie_genre)

    def update_movie(self, current_movie_id, current_movie_title, current_movie_description, current_movie_genre):
        self._undo_repository.update_movie(current_movie_id, current_movie_title, current_movie_description, current_movie_genre)

    def remove_client(self, client_id, client_name):
        self._undo_repository.remove_client(client_id, client_name)

    def add_client(self, given_client_id, given_client_name):
        self._undo_repository.add_client(given_client_id, given_client_name)

    def update_client(self, givenClient_id, givenClient_name):
        self._undo_repository.update_client(givenClient_id, givenClient_name)

    def remove_rental(self, rental_id, rented_movie_id, client_id_rental, rented_date, due_date, returned_date):
        return self._undo_repository.remove_rental(rental_id, rented_movie_id, client_id_rental, rented_date, due_date, returned_date)

    def return_the_movie(self, rented_movie_id):
        return self._undo_repository.return_movie(rented_movie_id)

    def undo(self):
        return self._undo_repository.undo(self._movie_service, self._client_service, self._rental_service)

    def redo(self):
        return self._undo_repository.redo(self._movie_service, self._client_service, self._rental_service)
