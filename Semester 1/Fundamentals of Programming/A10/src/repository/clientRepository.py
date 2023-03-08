from src.repository.repository_exception import RepositoryException
from src.repository.utilities import IterableData, filter_method
from random import choice
import json
from src.domain.client import Client
import pickle


class ClientRepository:
    def __init__(self, list_of_clients=None):
        if list_of_clients is None:
            self._list_of_clients = []
        if list_of_clients is IterableData:
            self._list_of_clients = list_of_clients
        else:
            self._list_of_clients = IterableData(list_of_clients)

    def add_new_client(self, new_client_id, new_client_name):
        """
        :param new_client_id: the id of the new client
        :param new_client_name: the name of the new client
        :return: adds the new movie to the clients.bin list
        """
        new_client = Client(new_client_id, new_client_name)
        self.check_if_id_is_valid(new_client)
        self.check_if_name_is_valid(new_client)
        for client in self._list_of_clients:
            if int(new_client.get_client_id) == int(client.get_client_id):
                raise RepositoryException("Client ID is already present.")
        self._list_of_clients.append(new_client)

    def find_and_return_the_client(self, client_id):
        """
        :param client_id: the id of the client to be found
        :return: the client for the given id
        """
        elements = filter_method(self._list_of_clients, lambda x: int(x.get_client_id) == int(client_id))
        if len(elements) == 0:
            return -1
        else:
            return elements[0].get_client_id

    def remove_client(self, client_ID):
        """
        :param client_ID: the client id that needs to be deleted
        :return: deletes the client for the given id
        """
        position = self.find_client_in_clients_list(client_ID)
        if position == -1:
            raise RepositoryException("Client with the given id does not exist.")
        self._list_of_clients.remove(position)

    def find_client_in_clients_list(self, client_id):
        """
        :param client_id: the id of the client that needs to be founded
        :return: the position of the corresponding client in the clients.bin list
        """
        index = 0
        for client in self._list_of_clients:
            if int(client.get_client_id) == int(client_id):
                return index
            index += 1

        return -1

    def display_clients(self):
        """
        This provides a string formed by all the movies.bin that need to pe printed
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
        :return: the string containing all the clients.bin which name match with the given word
        """
        list_of_matching_clients_for_the_name = ''
        for client_to_find in self._list_of_clients:
            if given_word_to_match_the_clients_name.lower() in client_to_find.get_name.lower():
                list_of_matching_clients_for_the_name += client_to_find.printClient()
        return list_of_matching_clients_for_the_name

    def determine_the_list_for_the_most_active_clients(self, list_of_the_sorted_rented_days):
        """
        :param list_of_the_sorted_rented_days: a list with the clients.bin id and the corresponding rented days
        :return: a string containing the most active clients.bin
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

    def get_all_clients(self):
        """
        :return: generates the 20 clients.bin randomly
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


class FileTextClientRepository(ClientRepository):
    def __init__(self, file_path):
        self.__file_path = file_path
        self.__read_function = Client.from_line
        self.__write_function = Client.to_line
        super().__init__()

    def _read_all_from_file(self):
        with open(self.__file_path, 'r') as f:
            self._list_of_clients.clear()
            lines = f.readlines()
            for line in lines:
                line = line.strip()
                if len(line):
                    client_id, client_name = self.__read_function(line)
                    super().add_new_client(client_id, client_name)

    def __write_all_to_file(self):
        with open(self.__file_path, 'w') as f:
            for client in self._list_of_clients:
                f.write(self.__write_function(client) + '\n')

    def __append_to_file(self, client):
        with open(self.__file_path, 'a') as f:
            f.write('\n' + self.__write_function(client))

    def add_new_client(self, client_id, client_name):
        self._read_all_from_file()
        super().add_new_client(client_id, client_name)
        self.__append_to_file(Client(client_id, client_name))

    def remove_client(self, client_id):
        self._read_all_from_file()
        super().remove_client(client_id)
        self.__write_all_to_file()

    def update_client(self, client_id, client_name):
        self._read_all_from_file()
        super().update_client(client_id, client_name)
        self.__write_all_to_file()

    def search_by_id(self, client_id):
        self._read_all_from_file()
        return super().find_client_in_clients_list(client_id)

    def get_all_clients(self):
        self._read_all_from_file()
        return self._list_of_clients


class FileBinaryClientRepository(ClientRepository):
    def __init__(self, file_path):
        self.__file_path = file_path
        self.__read_function = Client.from_line
        self.__write_function = Client.to_line
        super().__init__()

    def __read_all_from_file(self):
        with open(self.__file_path, 'rb') as f:
            self._list_of_clients.clear()
            try:
                self._list_of_clients = pickle.load(f)
            except EOFError:
                pass

    def __write_all_to_file(self):
        with open(self.__file_path, 'wb') as f:
            pickle.dump(self._list_of_clients, f)

    def __append_to_file(self, client):
        with open(self.__file_path, 'wb') as f:
            pickle.dump(self._list_of_clients, f)

    def add_new_client(self, client_id, client_name):
        self.__read_all_from_file()
        super().add_new_client(client_id, client_name)
        self.__append_to_file(Client(client_id, client_name))

    def remove_client(self, client_id):
        self.__read_all_from_file()
        super().remove_client(client_id)
        self.__write_all_to_file()

    def update_client(self, client_id, client_name):
        self.__read_all_from_file()
        super().update_client(client_id, client_name)
        self.__write_all_to_file()

    def search_by_id(self, client_id):
        self.__read_all_from_file()
        return super().find_client_in_clients_list(client_id)

    def get_all_clients(self):
        self.__read_all_from_file()
        return self._list_of_clients

    class FileJsonRepositoryClient(ClientRepository):
        def __init__(self, file_path):
            self.__file_path = file_path
            # self.__read_function = Client.from_line
            # self.__write_function = Client.to_line
            super().__init__()
            with open(self.__file_path, "r") as read_file:
                self._list_of_clients.clear()
                data = json.load(read_file)
            for current_data in data:
                self.add_new_client(current_data["client_id"], current_data["client_name"])

        def __write_all_to_file(self):
            clients_to_be_added = []
            for client in self._list_of_clients:
                clients_to_be_added.append(client.to_dictionary())
            with open(self.__file_path, "w") as write_file:
                write_file.write(json.dumps(clients_to_be_added))

        def add_new_client(self, client_id, client_name):
            super().add_new_client(client_id, client_name)
            self.__write_all_to_file()

        def remove_client(self, client_id):
            super().remove_client(client_id)
            self.__write_all_to_file()

        def update_client(self, client_id, client_name):
            super().update_client(client_id, client_name)

        def get_all_clients(self):
            return self._list_of_clients

    # def generate_the_clients(self):
    #     """
    #     :return: generates the 20 clients.bin randomly
    #     """
    #     n = 20
    #     for index in range(n):
    #         id_to_be_added = index
    #         random_chosen_client_by_computer = choice(list_of_available_clients)
    #         self.add_new_client(id_to_be_added+1, random_chosen_client_by_computer)
    #         list_of_available_clients.remove(random_chosen_client_by_computer)
    #     return self._list_of_clients



#list_of_available_clients = ["Mark Velimir", "Hollis Eve",  "Ryan Amaru",  "Talia Stace", "Major Jase", "Oswald Kendal",
 #                            "Theobald Madoline", "Ethan Leighton", "Buster Lizbeth", "Trevor Carreen", "Jeanie Tawnya",
  #                           "Berenice Ilean", "Trista Alvina", "Desmond Jacqui", "Mandy Carleton", "Alexia Megan",
   #                          "Jadyn Cyprian", "Shanon Elvin", "Webster Braiden", "Avery Sophia"]

