from src.repository.repository_exception import RepositoryException
from datetime import date


class UI:
    def __init__(self, movie_service, client_service, rental_service, undo_service):
        self._movie_service = movie_service
        self._client_service = client_service
        self._rental_service = rental_service
        self._undo_service = undo_service

    @staticmethod
    def show_menu(self):
        print('Available options: ')
        print('  1. Add')
        print('  2. Remove')
        print('  3. Update')
        print('  4. List')
        print('  5. Rent')
        print('  6. Return')
        print('  7. Search')
        print('  8. Statistics')
        print('  9. Undo/Redo')
        print('  0. Exit')

    def get_movie_data_to_add(self):
        movie_id = input("Enter the movie ID:")
        movie_title = input("Enter the movie title:")
        movie_description = input("Enter the movie description:")
        movie_genre = input("Enter the movie genre:")
        self._movie_service.add_movie(movie_id, movie_title, movie_description, movie_genre)
        self._undo_service.remove_movie(movie_id, movie_title, movie_description, movie_genre)

    def get_client_data_to_add(self):
        client_id = input("Enter the ID of the new client:  ")
        client_name = input("Enter the name of the new client:  ")
        self._client_service.add_client(client_id, client_name)
        self._undo_service.remove_client(client_id, client_name)

    def get_the_movie_ID_to_be_removed(self):
        movie_id = input(" Enter the ID of the movie you would like to remove:  ")
        movie_given_id, old_movie_title, old_movie_description, old_movie_genre = self._movie_service.get_data_for_updated_movie_for_undo(
            int(movie_id)-1)
        self._movie_service.remove_the_movie_with_given_id(movie_id)
        self._undo_service.add_movie(movie_id, old_movie_title, old_movie_description, old_movie_genre)

    def get_the_client_ID_to_be_removed(self):
        client_id = input(" Enter the ID of the client you would like to remove:  ")
        client_given_id, client_given_name = self._client_service.find_the_client_for_given_id(int(client_id)-1)
        self._client_service.remove_the_client_with_given_id(client_id)
        self._undo_service.add_client(client_id, client_given_name)

    def get_the_data_for_the_movie_to_be_updated(self, movie_id):
        users_given_movie_title = input("  Enter the title that you want to update:  ")
        users_given_movie_description = input("  Enter the description that you want to update:  ")
        users_given_movie_genre = input("  Enter the genre that you want to update:  ")
        movie_given_id, old_movie_title, old_movie_description, old_movie_genre = self._movie_service.get_data_for_updated_movie_for_undo(movie_id)
        self._movie_service.update(movie_id, users_given_movie_title,
                                   users_given_movie_description, users_given_movie_genre)
        self._undo_service.update_movie(movie_id, old_movie_title, old_movie_description, old_movie_genre)

    def get_the_data_for_the_client_to_be_updated(self, client_id):
        users_given_name_for_client = input("  Enter the name that you want to update:  ")
        client_given_id, client_old_name = self._client_service.find_the_client_for_given_id(client_id)
        self._client_service.update(client_id, users_given_name_for_client)
        self._undo_service.update_client(client_id, client_old_name)

    def get_data_for_renting_a_movie(self):
        given_id_for_rental = input("Enter the rental id:  ")
        if not given_id_for_rental.isnumeric() or int(given_id_for_rental) < 0:
            raise ValueError("Invalid id for the rental")
        self._rental_service.check_if_id_of_rental_is_already_in_list(given_id_for_rental)
        given_id_for_movie = input("Enter the movie id:  ")
        if self._movie_service.check(given_id_for_movie) == -1:
            raise ValueError("  Movie does not exits")
        if self._rental_service.check_if_a_movie_is_available(given_id_for_movie) is False:
            raise ValueError("Movie not available")
        given_id_for_the_client = input("Enter the Id of the client:  ")
        self._rental_service.check_if_a_client_is_able_to_rent(given_id_for_the_client)
        given_rented_day = date.today()
        given_rented_day = str(given_rented_day).split('-')
        given_due_day = input("Enter the due day for the rent:  ")
        given_due_month = input("Enter the due month for the rent:  ")
        given_due_year = input("Enter the due year for the rent:  ")
        due_date = (given_due_year, given_due_month, given_due_day)
        self._rental_service.add_rental_to_the_list(given_id_for_rental, given_id_for_movie, given_id_for_the_client, given_rented_day, due_date, None)
        self._undo_service.remove_rental(given_id_for_rental, given_id_for_movie, given_id_for_the_client, given_rented_day, due_date, None)
        print("Movie rented successfully!")

    def get_the_date(self, inserted_date):
        year = input("insert the year:")
        month = input("insert the month:")
        day = input("insert the day:")
        try:
            year = int(year)
            month = int(month)
            day = int(day)
            return [year, day, month]
        except ValueError as ve:
            "Invalid data"

    def get_id_for_movie_to_be_returned(self):
        movie_id_to_be_returned = input("  Enter the movie id you want to return:  ")
        if self._rental_service.check_if_a_movie_is_available(movie_id_to_be_returned) is True:
            raise ValueError("The movie cannot be returned because it has not been rented! ")
        else:
            # rental_given_id, movie_given_id, client_given_id, rented_given_date, due_rental_date, returned_rental_date = self._rental_service.get_the_data_for_movie_to_be_returned_undo(movie_id_to_be_returned)
            self._rental_service.update_a_movie_rented_status(movie_id_to_be_returned)
            self._undo_service.return_the_movie(movie_id_to_be_returned)
            # self._undo_service.return_the_movie(rental_given_id, movie_given_id, client_given_id, rented_given_date, due_rental_date, returned_rental_date)
            print("Movie returned successfully!")

    def get_user_option_for_searching_the_movies_or_clients(self):
        option_to_search = input("What would you like to search:\n 1.Movies \n 2.Clients  :  ")
        if option_to_search == "1":
            self.get_data_for_movie_to_search()
        elif option_to_search == "2":
            self.get_data_for_client_to_search()
        else:
            print("Option cannot be searched.")

    def get_data_for_movie_to_search(self):
        criteria_to_search_for_movie = input("Would you like to search based on: \n 1.Id \n 2.Title \n 3.Description \n 4.Genre:  ")
        if criteria_to_search_for_movie == "1":
            given_id_for_searching = input(" Enter the Id you are searching in the list:  ")
            list_with_searched_movies = self._movie_service.search_for_the_id_in_the_list_of_the_movies(given_id_for_searching)
            if list_with_searched_movies == '':
                print("  There is no movie with the given id!")
            else:
                print(list_with_searched_movies)
        elif criteria_to_search_for_movie == "2":
            given_title_for_searching = input(" Enter the title you are searching in the list:  ")
            list_with_searched_movies = self._movie_service.search_for_given_title_movies_list(
                given_title_for_searching)
            if list_with_searched_movies == '':
                print("  There is no movie with the given title!")
            else:
                print(list_with_searched_movies)
        elif criteria_to_search_for_movie == "3":
            given_description_for_searching = input(" Enter the description you are searching in the list:  ")
            list_with_searched_movies = self._movie_service.search_for_given_description_movies_list(
                given_description_for_searching)
            if list_with_searched_movies == '':
                print("  There is no movie with the given description!")
            else:
                print(list_with_searched_movies)
        elif criteria_to_search_for_movie == "4":
            given_genre_for_searching = input(" Enter the genre you are searching in the list:  ")
            list_with_searched_movies = self._movie_service.search_movie_for_given_genre(
                given_genre_for_searching)
            if list_with_searched_movies == '':
                print("  There is no movie with the given genre!")
            else:
                print(list_with_searched_movies)
        else:
            print("  Option not available for search.")

    def get_data_for_client_to_search(self):
        criteria_to_search_for_client = input("Would you like to search based on: \n 1.Id \n 2.Name:  ")
        if criteria_to_search_for_client == "1":
            given_id_for_searching = input(" Enter the Id you are searching in the list:  ")
            list_with_searched_clients = self._client_service.search_for_id_in_clients_list(
                given_id_for_searching)
            if list_with_searched_clients == '':
                print("  There is no client with the given id!")
            else:
                print(list_with_searched_clients)
        elif criteria_to_search_for_client == "2":
            given_name_for_searching = input(" Enter the name you are searching in the list:  ")
            list_with_searched_clients = self._client_service.search_for_clients_for_given_name(
                given_name_for_searching)
            if list_with_searched_clients == '':
                print("  There is no client with the given name!")
            else:
                print(list_with_searched_clients)
        else:
            print("  Option not available for search.")

    def get_user_option_for_statistics(self):
        chosen_statistic = input(" What would you like to see:  \n  1. Most rented movies.bin  \n  2.Most active clients.bin \n  3.Late rentals.bin:  ")
        if chosen_statistic == "1":
            movies_sorted_by_rented_days = dict(self._rental_service.statistics_for_rented_days_movies())
            sorted_list_of_the_movies = self._movie_service.sorted_movies_by_rented_days(movies_sorted_by_rented_days)
            print(sorted_list_of_the_movies)
        elif chosen_statistic == "2":
            clients_sorted_by_rented_days = dict(self._rental_service.statistics_for_rented_clients_days())
            sorted_list_of_the_clients_by_rented_days = self._client_service.statics_for_the_most_active_clients(clients_sorted_by_rented_days)
            print(sorted_list_of_the_clients_by_rented_days)
        elif chosen_statistic == "3":
            list_with_the_sorted_movies_still_rented = self._rental_service.statistics_for_rented_late_days()

            sorted_list_with_the_late_rented_days_movie = self._movie_service.sorted_movies_by_rented_days(list_with_the_sorted_movies_still_rented)
            print(sorted_list_with_the_late_rented_days_movie)
        else:
            print("  There is no statistic for the given category! ")

    def start(self):
        self._movie_service.generate_the_list_movies()
        self._client_service.generate_the_list_clients()
        self._rental_service.generate_the_list_of_rentals()

        while True:
            self.show_menu(self)
            user_option = input("   Enter your option: ")
            try:
                if user_option == '1':
                    option = input("What would you like to add:\n 1.Movie \n 2.Client  :  ")
                    if option == '1':
                        # try:
                        self.get_movie_data_to_add()
                        print("  Movie added successfully!")
                    elif option == '2':
                        self.get_client_data_to_add()
                        print("  Client added successfully!")
                    else:
                        print("  Option not available to add.")
                elif user_option == '2':
                    option = input("What would you like to remove: \n 1.Movie \n 2.Client  :  ")
                    if option == '1':
                        self.get_the_movie_ID_to_be_removed()
                        print("  Movie removed successfully!")
                    elif option == '2':
                        self.get_the_client_ID_to_be_removed()
                        print("  Client removed successfully!")
                    else:
                        raise ValueError("  Option not available to remove.")
                elif user_option == '3':
                    option = input("What would you like to update: \n 1.Movie \n 2.Client  :  ")
                    if option == '1':
                        user_given_id_for_updating_the_movie = input("  Enter the Id of the movie you would like to update:  ")
                        user_given_id_for_updating_the_movie = self._movie_service.check(user_given_id_for_updating_the_movie)
                        if user_given_id_for_updating_the_movie == -1:
                            print("  There is no movie with the given id!")
                        else:
                            self.get_the_data_for_the_movie_to_be_updated(user_given_id_for_updating_the_movie)
                            print("  Movie updated successfully!")
                    elif option == '2':
                        user_given_id_for_updating_the_client = input(
                            "  Enter the Id of the client you would like to update:  ")
                        user_given_id_for_updating_the_client = self._client_service.check(user_given_id_for_updating_the_client)
                        if user_given_id_for_updating_the_client == -1:
                            print("  There is no client with the given id!")
                        else:
                            self.get_the_data_for_the_client_to_be_updated(user_given_id_for_updating_the_client)
                            print("  Client updated successfully!")
                    else:
                        print("  Category not available to update.")
                elif user_option == '4':
                    option_to_list = input("What would you like to list: \n 1.Movies \n 2.Clients  :  ")
                    if option_to_list == '1':
                        movies_to_print = self._movie_service.list_movies()
                        print(movies_to_print)
                    elif option_to_list == '2':
                        clients_to_print = self._client_service.list_clients()
                        print(clients_to_print)
                    else:
                        print("  Option not available to list.")
                elif user_option == '5':
                    self.get_data_for_renting_a_movie()
                elif user_option == '6':
                    self.get_id_for_movie_to_be_returned()
                elif user_option == '7':
                    self.get_user_option_for_searching_the_movies_or_clients()
                elif user_option == '8':
                    self.get_user_option_for_statistics()
                elif user_option == '9':
                    option_to_undo_redo = input("What would you like to do: \n 1.Undo \n 2.Redo  :  ")
                    if option_to_undo_redo == '1':
                        self._undo_service.undo()
                        print("  Undo done successfully!")
                    elif option_to_undo_redo == '2':
                        self._undo_service.redo()
                        print("  Redo done successfully!")
                    else:
                        raise ValueError("  Option not available for undo/redo.")
                elif user_option == '0':
                    return
                else:
                    print("   The option does not exist. ")
            except RepositoryException as ve:
                print(str(ve))
            except ValueError as re:
                print(str(re))




