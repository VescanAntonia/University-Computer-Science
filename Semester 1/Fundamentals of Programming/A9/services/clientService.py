class ClientService:
    def __init__(self, client_repository):
        self._client_repository = client_repository

    def add_client(self, client_id, client_name):
        self._client_repository.add_new_client(client_id, client_name)

    def remove_the_client_with_given_id(self, clientID):
        return self._client_repository.remove_client(clientID)

    def list_clients(self):
        return self._client_repository.display_clients()

    def update(self, new_client_id, users_given_name_for_client):
        return self._client_repository.update_client(new_client_id, users_given_name_for_client)

    def check(self, given_id):
        return self._client_repository.find_client_in_clients_list(given_id)

    def generate_the_list_clients(self):
        return self._client_repository.get_all_clients()

    def search_for_id_in_clients_list(self, given_id_for_searching):
        return self._client_repository.search_based_on_the_id_in_clients_list(given_id_for_searching)

    def search_for_clients_for_given_name(self, given_name_to_search):
        return self._client_repository.search_based_on_the_name(given_name_to_search)

    def statics_for_the_most_active_clients(self, given_sorted_with_rented_days):
        return self._client_repository.determine_the_list_for_the_most_active_clients(given_sorted_with_rented_days)

    def find_the_client_for_given_id(self, given_id):
        return self._client_repository.get_the_client_data_for_the_given_id(given_id)
