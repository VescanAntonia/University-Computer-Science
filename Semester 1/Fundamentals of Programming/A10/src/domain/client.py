class Client:
    def __init__(self, client_id, name):
        self.__client_id = client_id
        self.__name = name

    @property
    def get_client_id(self):
        """
        returns the Id of the client object
        """
        return self.__client_id

    @property
    def get_name(self):
        """
        returns the name of the client object
        """
        return self.__name

    def printClient(self):
        return '  Client Id: ' + str(self.__client_id) + ' Name: ' + str(self.__name) + '\n'

    def set_id(self, new_id):
        self.__client_id = new_id

    def set_name(self, client_name):
        self.__name = client_name

    @staticmethod
    def from_line(line):
        client_data = line.split(",")
        client_id = int(client_data[0])
        client_name = client_data[1]
        return [client_id, client_name]

    @staticmethod
    def to_line(client):
        line = f"{str(client.get_client_id)},{client.get_name}"
        return line


def return_the_getters_true():
    movie_to_test1 = Client(1, 'a')
    assert movie_to_test1.get_client_id == 1
    assert movie_to_test1.get_name == 'a'

    movie_to_test2 = Client(2, 'b')
    assert movie_to_test2.get_client_id == 2
    assert movie_to_test2.get_name == 'b'

    movie_to_test3 = Client(3, 'c')
    assert movie_to_test3.get_client_id == 3
    assert movie_to_test3.get_name == 'c'

    movie_to_test4 = Client(4, 'd')
    assert movie_to_test4.get_client_id == 4
    assert movie_to_test4.get_name == 'd'

    movie_to_test5 = Client(5, 'e')
    assert movie_to_test5.get_client_id == 5
    assert movie_to_test5.get_name == 'e'


return_the_getters_true()