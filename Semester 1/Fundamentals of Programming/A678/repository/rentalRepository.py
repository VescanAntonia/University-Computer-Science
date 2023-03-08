import datetime
from src.domain.rental import Rental
from src.repository.repository_exception import RepositoryException
from datetime import date
from random import choice
import operator


class RentalRepository:
    def __init__(self):
        self.list_of_rental = []

    def add_new_rental(self, rental_id, movie_rental_id, client_rental_id, rented_date, due_date, returned_date):
        """
        :param rental_id: the id of the new rental
        :param movie_rental_id: the id of the movie
        :param client_rental_id: the id of the client
        :param rented_date: the rented date for the movie
        :param due_date: the due date for the movie
        :param returned_date: the returned date for the movie
        :return: adds the new rental to the list
        """
        for rental in self.list_of_rental:
            if rental_id == rental.get_rental_id:
                raise RepositoryException("Duplicate rental ID")
        self.check_validity_of_new_rental(Rental(rental_id, movie_rental_id, client_rental_id, rented_date, due_date, returned_date))
        self.list_of_rental.append(Rental(rental_id, movie_rental_id, client_rental_id, rented_date, due_date,
                                          returned_date))

    def remove(self, rental_id):
        """
        :return: remove the rental for the given id
        """
        does_id_rental_exists = self.find_the_id_of_the_rental_in_list(rental_id)
        if does_id_rental_exists == -1:
            raise RepositoryException("  There is not rental with the given id!")
        self.list_of_rental.pop(does_id_rental_exists)

    def check_if_rental_id_exists(self, given_id):
        """
        :param given_id: the given id for the rental
        :return: checks if it exists a rental for the given id
        """
        does_id_rental_exists = self.find_the_id_of_the_rental_in_list(given_id)
        if not does_id_rental_exists == -1:
            raise RepositoryException(" Rental Id already in rental")

    def check_the_availability_of_the_movie(self, movie_id):
        """
        :param movie_id: the id of the movie
        :return: checks if a movie is available for rent or not
        """
        position_in_list = self.search_the_movie_in_rental_list(movie_id)
        if len(self.list_of_rental[position_in_list].get_due_date) == 0:
            return True
        if position_in_list == -1 or not self.compare_two_dates(self.list_of_rental[position_in_list].get_returned_date, self.list_of_rental[position_in_list].get_due_date):
            return True

        return False

    def find_the_id_of_the_rental_in_list(self, given_id):
        """
        :return: the position of a rental for the given id
        """
        position = 0
        for rent in self.list_of_rental:
            if int(rent.get_rental_id) == int(given_id):
                return position
            position += 1
        return -1

    def search_the_movie_in_rental_list(self, id_movie):
        """
        :param id_movie: id of a movie to be searched in the rentals list
        :return: the position of the rental for the given movie in list
        """
        index = 0
        for movie in self.list_of_rental:
            if int(movie.get_movie_id) == int(id_movie):
                return index
            index += 1
        return -1

    def search_for_client_in_rental_list(self, client_id):
        """
        :return: the position in list for a client with the given id
        """
        index = 0
        position_in_list = 0
        for client in self.list_of_rental:
            if int(client.get_client_id) == int(client_id):
                position_in_list = index
            index += 1
        return position_in_list

    def check_if_a_client_has_the_right_to_rent_a_movie(self, clientId):
        """
        :return: checks if a client has the right to rent a movie or not
        """
        is_client_in_list = self.find_client_in_rental_list(clientId)
        if is_client_in_list == -1:
            return True
        elif self.list_of_rental[is_client_in_list].get_returned_date is None and self.get_the_date_for_given_data(self.list_of_rental[is_client_in_list].get_due_date) < date.today():
            raise RepositoryException("Client not able to rent")
        elif (self.list_of_rental[is_client_in_list].get_returned_date is None and self.get_the_date_for_given_data(self.list_of_rental[is_client_in_list].get_due_date) > date.today()) or self.get_the_date_for_given_data(self.list_of_rental[is_client_in_list].get_due_date) <= self.get_the_date_for_given_data(self.list_of_rental[is_client_in_list].get_returned_date):
            return True
        else:
            raise RepositoryException("Client is not able to rent!")

    def compare_the_dates_for_the_rent(self, given_date):
        """
        :return: compares a given date with todays date
        """
        given_date_to_compare = datetime.date(int(given_date[0]), int(given_date[1]), int(given_date[2]))
        present = date.today()
        return given_date_to_compare < present

    def compare_two_dates(self, first_given_date, second_given_date):
        """
        :return: compares two given dates
        """
        if second_given_date is None or first_given_date is None:
            return True
        first_date_to_compare = datetime.date(int(first_given_date[0]), int(first_given_date[1]), int(first_given_date[2]))
        second_date_to_compare = datetime.date(int(second_given_date[0]), int(second_given_date[1]), int(second_given_date[2]))
        return first_date_to_compare > second_date_to_compare

    def update_returned_date_for_movie(self, id_of_movie):
        """
        :param id_of_movie: id of the movie which status needs to be updated
        :return: the updated status of the returned movie
        """
        is_movie_in_list = self.search_the_movie_in_rental_list(id_of_movie)
        if len(self.list_of_rental[is_movie_in_list].get_due_date) == 0:
            raise RepositoryException("Movie cannot be returned because it wan not rented!")
        position = self.search_the_movie_in_rental_list(id_of_movie)
        current_day = date.today()
        current_day = str(current_day).split('-')
        day = current_day[2]
        month = current_day[1]
        year = current_day[0]
        self.list_of_rental[position].set_returned_date([year, month, day])

    def update_unreturned_status(self, id_of_movie):
        position = self.search_the_movie_in_rental_list(id_of_movie)
        self.list_of_rental[position].set_returned_date(None)

    def get_data_of_movie_to_be_returned(self, id_of_movie):
        position = self.search_the_movie_in_rental_list(id_of_movie)
        return self.list_of_rental[position-1].get_rental_id, self.list_of_rental[position-1].get_movie_id, self.list_of_rental[position-1].get_client_id, self.list_of_rental[position-1].get_rented_date, self.list_of_rental[position-1].get_due_date, self.list_of_rental[position-1].get_returned_date

    def get_date(self, given_date):
        """
        :return: splits a given date and get the corresponding data
        """
        given_date = given_date.split('-')
        year_of_the_rental = given_date[0]
        month_of_the_rental = given_date[1]
        day_of_the_rental = given_date[2]
        return [year_of_the_rental, month_of_the_rental, day_of_the_rental]

    def determine_the_numbers_of_days_rented_current_movie(self, movie_given_id):
        """
        :param movie_given_id: the id of the movie to be founded
        :return: calculates the total of days a movie has been rented
        """
        total_days_for_rental_of_the_given_movie = 0
        days_for_current_rental_in_list = 0
        for rental in self.list_of_rental:
            if int(rental.get_movie_id) == int(movie_given_id):
                if rental.get_returned_date is None:
                    returned_date_to_compare = date.today()
                else:
                    returned_date_to_compare = self.get_the_date_for_given_data(rental.get_returned_date)
                rented_day_to_compare = self.get_the_date_for_given_data(rental.get_rented_date)
                days_for_current_rental_in_list = (returned_date_to_compare-rented_day_to_compare).days
                total_days_for_rental_of_the_given_movie += int(days_for_current_rental_in_list)
        return total_days_for_rental_of_the_given_movie

    def get_the_date_for_given_data(self, given_data):
        year = int(given_data[0])
        month = int(given_data[1])
        day = int(given_data[2])
        return date(year, month, day)

    def find_client_in_rental_list(self, client_given_id):
        """
        :return: the position of a client in rental list
        """
        index = 0
        for client in self.list_of_rental:
            if int(client.get_client_id) == int(client_given_id):
                return index
            index += 1
        return -1

    def movies_sorted_by_rented_days(self):
        """
        :return: a list containing the movies ids and the corresponding rented days in descending order
        """
        sorted_movies_dictionary = {}  # movies id as the keys and movies corresponding rented days as the values
        for rent in self.list_of_rental:
            total_day_of_renting_the_current_movie = self.determine_the_numbers_of_days_rented_current_movie(rent.get_movie_id)
            sorted_movies_dictionary[rent.get_movie_id] = total_day_of_renting_the_current_movie
        new_list_with_movies_sorted_by_value_is_total_rented_days = sorted(sorted_movies_dictionary.items(), key=operator.itemgetter(1), reverse=True)
        return new_list_with_movies_sorted_by_value_is_total_rented_days

    def determine_the_numbers_of_total_rented_days_for_given_client(self, client_given_id):
        """
        :return: calculates the total of days a client has rented movies
        """
        total_days_for_rental_of_the_given_clients = 0
        days_for_current_rental_in_list = 0
        for rental in self.list_of_rental:
            if int(rental.get_client_id) == int(client_given_id):
                if rental.get_returned_date is None:
                    returned_date_to_compare = date.today()
                else:
                    returned_date_to_compare = self.get_the_date_for_given_data(rental.get_returned_date)
                rented_day_to_compare = self.get_the_date_for_given_data(rental.get_rented_date)
                days_for_current_rental_in_list = (returned_date_to_compare - rented_day_to_compare).days
                total_days_for_rental_of_the_given_clients += int(days_for_current_rental_in_list)
        return total_days_for_rental_of_the_given_clients

    def clients_sorted_by_rented_days_they_have(self):
        """
        :return: a list containing the clients ids and the corresponding rented days in descending order
        """
        sorted_clients_dictionary = {}  # clients id as the keys and clients corresponding rented days as the values
        for rental in self.list_of_rental:
            total_days_of_renting_of_the_current_client = self.determine_the_numbers_of_total_rented_days_for_given_client(rental.get_client_id)
            sorted_clients_dictionary[rental.get_client_id] = total_days_of_renting_of_the_current_client
        new_list_with_clients_sorted_by_total_rented_days = sorted(sorted_clients_dictionary.items(), key=operator.itemgetter(1), reverse=True)
        return new_list_with_clients_sorted_by_total_rented_days

    def determine_the_total_late_days_for_movie_rent(self, movie_rented_date):
        """
        :return: determine the late days for the movie that is currently rented
        """
        todays_date = date.today()
        rented_late_date = self.get_the_date_for_given_data(movie_rented_date)
        total_late_days = (todays_date - rented_late_date).days
        return total_late_days

    def sorted_list_for_currently_rented_movies_which_due_date_expired(self):
        """
        :return: a list containing the movies ids and the corresponding late rented days in descending order
        """
        movies_dictionary_to_sort = {}
        for rent in self.list_of_rental:
            if rent.get_returned_date is None and self.get_the_date_for_given_data(rent.get_due_date) < date.today():
                get_the_total_of_rented_days_for_current_movie = self.determine_the_total_late_days_for_movie_rent(rent.get_rented_date)
                movies_dictionary_to_sort[rent.get_movie_id] = get_the_total_of_rented_days_for_current_movie
        new_list_with_movies_to_sort = sorted(movies_dictionary_to_sort.items(), key=operator.itemgetter(1), reverse=True)
        return new_list_with_movies_to_sort

    def check_validity_of_new_rental(self, new_rental):
        """
        :return: checks if a movies id is a positive number and if its title, description and genre are strings
        """
        if not str(new_rental.get_rental_id).isnumeric() or int(new_rental.get_rental_id) < 0:
            raise RepositoryException("Invalid id for the rental")
        if not str(new_rental.get_client_id).isnumeric() or int(new_rental.get_client_id) < 0:
            raise RepositoryException("Invalid id for the client")
        if not str(new_rental.get_movie_id).isnumeric() or int(new_rental.get_movie_id) < 0:
            raise RepositoryException("Invalid id for the movie")
        if not str(new_rental.get_rented_date[0]).isnumeric() or int(new_rental.get_rented_date[0]) < 0 or not str(
                new_rental.get_rented_date[1]).isnumeric() or 31 < int(new_rental.get_rented_date[1]) < 0 or not str(
                new_rental.get_rented_date[2]).isnumeric() or int(new_rental.get_rented_date[2]) < 0:
            raise RepositoryException("Invalid rent date")
        if not str(new_rental.get_due_date[0]).isnumeric() or int(new_rental.get_due_date[0]) < 0 or not str(
                new_rental.get_due_date[1]).isnumeric() or 31 < int(new_rental.get_due_date[1]) < 0 or not str(
                new_rental.get_due_date[2]).isnumeric() or int(new_rental.get_due_date[2]) < 0:
            raise RepositoryException("Invalid due date")

    def generate_the_rentals_list(self):
        """
        :return: generates randomly the list of rentals
        """
        for i in range(4):
            rental_chosen_randomly_by_computer = choice(list_of_rentals_to_choose_from)
            rental_given_id = i+1
            movie_rental_id = rental_chosen_randomly_by_computer[0]
            client_rental_id = rental_chosen_randomly_by_computer[1]
            rented_rental_date = rental_chosen_randomly_by_computer[2]
            due_date_rental = rental_chosen_randomly_by_computer[3]
            returned_rental_date = rental_chosen_randomly_by_computer[4]
            self.add_new_rental(rental_given_id, movie_rental_id, client_rental_id, rented_rental_date, due_date_rental, returned_rental_date)
            list_of_rentals_to_choose_from.remove(rental_chosen_randomly_by_computer)
        return self.list_of_rental

    def get_today_date(self):
        present_date = str(date.today())
        present_date = self.get_date(present_date)
        return present_date


list_of_rentals_to_choose_from = [("7", "5", ["2021", "8", "3"], ["2021", "9", "1"], None), ("19", "2", ["2021", "5", "6"], ["2021", "7", "9"], ["2021", "7", "8"]), ("5", "3", ["2021", "5", "19"], ["2021", "7", "20"], ["2021", "7", "21"]),
                                   ("3", "6", ["2021", "6", "3"], ["2021", "7", "1"], None)]


# def add_new_rental_is_true():
#     function = RentalRepository()
#     function.add_new_rental("1", "20", "5", "2021-4-8", "2021-6-9", None)
#
#
# add_new_rental_is_true()
#
#
# def add_new_rental_throws_id_must_be_a_number():
#     function = RentalRepository()
#     try:
#         function.add_new_rental("m", "20", "5", "2021-4-8", "2021-6-9", None)
#     except RepositoryException as re:
#         assert str(re)
#
#
# add_new_rental_throws_id_must_be_a_number()
#
#
# def add_new_rental_throws_id_must_be_a_positive_number():
#     function = RentalRepository()
#     try:
#         function.add_new_rental("-50", "20", "5", "2021-4-8", "2021-6-9", None)
#     except RepositoryException as re:
#         assert str(re)
#
#
# add_new_rental_throws_id_must_be_a_positive_number()
#
#
# def add_new_rental_throws_movie_id_must_be_a_positive_number():
#     function = RentalRepository()
#     try:
#         function.add_new_rental("20", "-20", "5", "2021-4-8", "2021-6-9", None)
#     except RepositoryException as re:
#         assert str(re)
#
#
# add_new_rental_throws_movie_id_must_be_a_positive_number()
#
#
# def add_new_rental_throws_client_id_must_be_a_positive_number():
#     function = RentalRepository()
#     try:
#         function.add_new_rental("20", "20", "-5", "2021-4-8", "2021-6-9", None)
#     except RepositoryException as re:
#         assert str(re)
#
#
# add_new_rental_throws_client_id_must_be_a_positive_number()
#
#
# def add_new_rental_throws_invalid_rent_date():
#     function = RentalRepository()
#     try:
#         function.add_new_rental("20", "20", "5", "-1", "2021-6-7", None)
#     except RepositoryException as re:
#         assert str(re)
#
#
# add_new_rental_throws_invalid_rent_date()
#
#
# def add_new_rental_throws_invalid_due_date():
#     function = RentalRepository()
#     try:
#         function.add_new_rental("20", "20", "5", "2021-6-5", "-2", None)
#     except RepositoryException as re:
#         assert str(re)
#
#
# add_new_rental_throws_invalid_due_date()
#
#
# def find_if_of_rental_is_true():
#     function = RentalRepository()
#     function.add_new_rental("20", "20", "5", "2021-6-5", "2021-6-5", None)
#     assert function.find_the_id_of_the_rental_in_list(20) != -1
#
#
# find_if_of_rental_is_true()
#
#
# def find_if_of_rental_is_false():
#     function = RentalRepository()
#     assert function.find_the_id_of_the_rental_in_list(20) == -1
#
#
# find_if_of_rental_is_true()
#
#
# def compare_the_dates_is_true():
#     function = RentalRepository()
#     assert function.compare_the_dates_for_the_rent([2021, 2, 5]) is True
#
#
# compare_the_dates_is_true()
#
#
# def compare_the_dates_is_false():
#     function = RentalRepository()
#     assert function.compare_the_dates_for_the_rent([2021, 12, 5]) is False
#
#
# compare_the_dates_is_false()
#
#
# def get_date_returns_true():
#     function = RentalRepository()
#     assert function.get_date("2021-12-1") == ['2021', '12', '1']
#
#
# get_date_returns_true()
#
#
# def search_for_movie_in_rental_list__returns_true():
#     function = RentalRepository()
#     function.add_new_rental("20", "20", "5", "2021-6-5", "2021-6-5", None)
#     assert function.search_for_client_in_rental_list(5) != -1
#
#
# search_for_movie_in_rental_list__returns_true()
#
#
# def search_for_movie_in_rental_list__returns_true():
#     function = RentalRepository()
#     assert function.search_for_client_in_rental_list(5) == 0
#
#
# search_for_movie_in_rental_list__returns_true()
#
#
# def update_rented_day__return_true():
#     function = RentalRepository()
#     function.add_new_rental("20", "20", "5", "2021-6-5", "2021-6-5", None)
#     function.update_returned_date_for_movie(20)
#
#
# update_rented_day__return_true()
