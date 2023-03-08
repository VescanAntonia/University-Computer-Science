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


def read_text_file(file_name):
    result = []
    try:
        f = open(file_name, "r")
        line = f.readline().strip()
        while len(line) > 0:
            line = line.split(";")
            result.append(Client(int(line[0]), line[1]))
            line = f.readline().strip()
        f.close()
    except IOError as e:
        """
            Here we 'log' the error, and throw it to the outer layers 
        """
        print("An error occured - " + str(e))
        raise e

    return result


# list_clients = [Client(101, "Alice"), Client(102, "Bob")]
#
# write_text_file("persons.txt", persons)
#
# """
#     Read it back and see what we have
# """
# for p in read_text_file("persons.txt"):
#     print(p)
