from src.repository.repository_exception import RepositoryException
from random import choice
from src.domain.client import Client


class ClientRepository:
    def __init__(self):
        self._list_of_clients = []

    def add_new_client(self, new_client_id, new_client_name):
        """
        :param new_client_id: the id of the new client
        :param new_client_name: the name of the new client
        :return: adds the new movie to the clients list
        """
        new_client = Client(new_client_id, new_client_name)
        self.check_if_id_is_valid(new_client)
        self.check_if_name_is_valid(new_client)
        for client in self._list_of_clients:
            if int(new_client.get_client_id) == int(client.get_client_id):
                raise RepositoryException("Client ID is already present.")
        self._list_of_clients.append(new_client)

    def remove_client(self, client_ID):
        """
        :param client_ID: the client id that needs to be deleted
        :return: deletes the client for the given id
        """
        position = self.find_client_in_clients_list(client_ID)
        if position == -1:
            raise RepositoryException("Client with the given id does not exist.")
        self._list_of_clients.pop(position)

    def find_client_in_clients_list(self, client_id):
        """
        :param client_id: the id of the client that needs to be founded
        :return: the position of the corresponding client in the clients list
        """
        index = 0
        for client in self._list_of_clients:
            if int(client.get_client_id) == int(client_id):
                return index
            index += 1

        return -1

    def display_clients(self):
        """
        This provides a string formed by all the movies that need to pe printed
        """
        clients_list_to_display = ''
        for client in self._list_of_clients:
            clients_list_to_display += client.printClient()
        return clients_list_to_display

    def update_client(self, new_client_id, users_given_name_for_client):
        """
        :param new_client_id: the given client id
        :param users_given_name_for_client: the new name of the client
        :return: updates the details for the given client
        """
        new_client = Client(new_client_id, users_given_name_for_client)
        self.check_if_id_is_valid(new_client)
        self.check_if_name_is_valid(new_client)
        position = self.find_client_in_clients_list(new_client.get_client_id)+1
        self._list_of_clients[position].set_name(new_client.get_name)

    def check_if_id_is_valid(self, client):
        """
        this checks if the given id for the client is a positive number
        """
        if not str(client.get_client_id).isnumeric():
            raise RepositoryException("  Id must be a number!")
        if int(client.get_client_id) < 0:
            raise RepositoryException("  Id cannot be a negative number! ")

        return True

    def check_if_name_is_valid(self, client):
        """
        this checks if a given name for the client is valid, meaning it is not a number
        """
        if str(client.get_name).isnumeric():
            raise RepositoryException("  Client name cannot be a number!")
        if client.get_name == '':
            raise RepositoryException("  No name has been added!")
        return True

    def search_based_on_the_id_in_clients_list(self, given_id_to_search):
        """
        This provides the client for the given id
        """
        list_of_found_clients = ''
        for client in self._list_of_clients:
            if int(client.get_client_id) == int(given_id_to_search):
                list_of_found_clients += client.printClient()
        return list_of_found_clients

    def search_based_on_the_name(self, given_word_to_match_the_clients_name):
        """
        :param given_word_to_match_the_clients_name: the given word that need to match the name of the client
        :return: the string containing all the clients which name match with the given word
        """
        list_of_matching_clients_for_the_name = ''
        for client_to_find in self._list_of_clients:
            if given_word_to_match_the_clients_name.lower() in client_to_find.get_name.lower():
                list_of_matching_clients_for_the_name += client_to_find.printClient()
        return list_of_matching_clients_for_the_name

    def determine_the_list_for_the_most_active_clients(self, list_of_the_sorted_rented_days):
        """
        :param list_of_the_sorted_rented_days: a list with the clients id and the corresponding rented days
        :return: a string containing the most active clients
        """
        list_of_the_sorted_rented_days = dict(list_of_the_sorted_rented_days)
        clients_sorted_list = ''
        new_list_with_the_keys_clients_ids = list(list_of_the_sorted_rented_days.keys())
        for element in new_list_with_the_keys_clients_ids:
            client_index_in_list = self.find_client_in_clients_list(element)
            clients_sorted_list += self._list_of_clients[client_index_in_list].printClient()
        return clients_sorted_list

    def get_the_client_data_for_the_given_id(self, given_client_id):
        client_position_in_list = self.find_client_in_clients_list(given_client_id)+1
        current_client = self._list_of_clients[client_position_in_list]
        return given_client_id, current_client.get_name

    def generate_the_clients(self):
        """
        :return: generates the 20 clients randomly
        """
        n = 20
        for index in range(n):
            id_to_be_added = index
            random_chosen_client_by_computer = choice(list_of_available_clients)
            self.add_new_client(id_to_be_added+1, random_chosen_client_by_computer)
            list_of_available_clients.remove(random_chosen_client_by_computer)
        return self._list_of_clients


list_of_available_clients = ["Mark Velimir", "Hollis Eve",  "Ryan Amaru",  "Talia Stace", "Major Jase", "Oswald Kendal",
                             "Theobald Madoline", "Ethan Leighton", "Buster Lizbeth", "Trevor Carreen", "Jeanie Tawnya",
                             "Berenice Ilean", "Trista Alvina", "Desmond Jacqui", "Mandy Carleton", "Alexia Megan",
                             "Jadyn Cyprian", "Shanon Elvin", "Webster Braiden", "Avery Sophia"]


# def add_client_return_true():
#     repository = ClientRepository()
#     repository.add_new_client("75", "M")
#
# add_client_return_true()
#
#
# def add_client_throws_id_must_be_a_number(self):
#     function_add_to_test = ClientRepository()
#     try:
#         function_add_to_test.add_new_client("m", "M")
#         assert False
#     except RepositoryException as ve:
#         assert str(ve)
#
#     self.add_client_throws_id_must_be_a_number()

#
# def add_client_throws_id_must_be_a_positive_number():
#     function_add_to_test = ClientRepository()
#     try:
#         function_add_to_test.add_new_client(-1, "M")
#         assert False
#     except RepositoryException as ve:
#         assert str(ve)
#
#
# add_client_throws_id_must_be_a_positive_number()


# def add_movie_id_invalid():
#     function_add_to_test = ClientRepository()
#     try:
#         function_add_to_test.add_new_client("-1", "M")
#         assert False
#     except RepositoryException as ve:
#         assert str(ve)
#
#
# add_movie_id_invalid()
#
#
# def add_client_throws_id_must_be_unique():
#     function_add_to_test = ClientRepository()
#     function_add_to_test.add_new_client(5, "M")
#     try:
#         function_add_to_test.add_new_client(5, "M")
#         assert False
#     except RepositoryException as re:
#         assert(str(re))
#
#
# add_client_throws_id_must_be_unique()
#
#
# def remove_client_with_given_id_is_true():
#     function_remove_to_test = ClientRepository()
#     function_remove_to_test.add_new_client(5, "M")
#     function_remove_to_test.remove_client(5)
#
#
# remove_client_with_given_id_is_true()
#
#
# def remove_client_with_given_id_throws_id_does_not_exist():
#     remove_to_test = ClientRepository()
#     try:
#         remove_to_test.remove_client(10)
#         assert False
#     except RepositoryException as re:
#         assert str(re)
#
#
# remove_client_with_given_id_throws_id_does_not_exist()
#
#
# def update_the_client_throws_name_cannot_be_a_number():
#     function = ClientRepository()
#     try:
#         function.update_client("70", 5)
#         assert False
#     except RepositoryException as re:
#         assert str(re)
#
#
# update_the_client_throws_name_cannot_be_a_number()
#
#
# def update_the_client_throws_no_name_has_been_added():
#     function = ClientRepository()
#     try:
#         function.update_client("77", '')
#         assert False
#     except RepositoryException as re:
#         assert str(re)
#
#
# update_the_client_throws_no_name_has_been_added()
#
#
# def check_if_a_client_is_in_list_returns_true():
#     function = ClientRepository()
#     assert function.find_client_in_clients_list(5) != 0
#
#
# check_if_a_client_is_in_list_returns_true()
#
#
# def check_if_a_client_is_in_list_returns_false():
#     function = ClientRepository()
#     assert function.find_client_in_clients_list(73) == -1
#
#
# check_if_a_client_is_in_list_returns_false()
#
#
# def find_client_returns_true():
#     function= ClientRepository()
#     function.add_new_client(5, "m")
#     assert function.find_client_in_clients_list(5) != -1
#
#
# find_client_returns_true()
#
#
# def find_client_returns_false():
#     function = ClientRepository()
#     assert function.find_client_in_clients_list(111) == -1
#
#
# find_client_returns_false()
