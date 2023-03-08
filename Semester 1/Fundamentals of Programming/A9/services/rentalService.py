class RentalService:
    def __init__(self, rental_repository):
        self._rental_repository = rental_repository

    def add_rental_to_the_list(self, rental_id, movie_id, client_id, rented_date, due_date, returned_date):
        return self._rental_repository.add_new_rental(rental_id, movie_id, client_id, rented_date, due_date, returned_date)

    def check_if_id_of_rental_is_already_in_list(self, rentalId):
        return self._rental_repository.check_if_rental_id_exists(rentalId)

    def check_if_a_movie_is_available(self, id_of_the_movie):
        return self._rental_repository.check_the_availability_of_the_movie(id_of_the_movie)

    def check_if_a_client_is_able_to_rent(self, client_id):
        return self._rental_repository.check_if_a_client_has_the_right_to_rent_a_movie(client_id)

    def update_a_movie_rented_status(self, movie_id):
        return self._rental_repository.update_returned_date_for_movie(movie_id)

    def generate_the_list_of_rentals(self):
        return self._rental_repository.get_all_rentals()

    def statistics_for_rented_days_movies(self):
        return self._rental_repository.movies_sorted_by_rented_days()

    def statistics_for_rented_clients_days(self):
        return self._rental_repository.clients_sorted_by_rented_days_they_have()

    def statistics_for_rented_late_days(self):
        return self._rental_repository.sorted_list_for_currently_rented_movies_which_due_date_expired()

    def remove_rental(self, rental_id):
        return self._rental_repository.remove(rental_id)

    def update_unreturned_status_movie(self, movie_rented_id):
        return self._rental_repository.update_unreturned_status(movie_rented_id)

    def get_the_data_for_movie_to_be_returned_undo(self, movie_id_rental):
        return self._rental_repository.get_data_of_movie_to_be_returned(movie_id_rental)

    def print_the_rentals(self):
        return self._rental_repository.print_rentals()
