class Rental:
    def __init__(self, rental_id, client_name, car_model, rented_date, returned_date):
        self.__rental_id = rental_id
        self.__client_name = client_name
        self.__car_model = car_model
        self.__rented_date = rented_date
        self.__returned_date = returned_date

    @property
    def get_rental_id(self):
        """
        returns the rental Id of a rental object
        """
        return self.__rental_id

    @property
    def get_client(self):
        """
        returns the movie Id of a rental object
        """
        return self.__client_name

    @property
    def get_car_model(self):
        """
        returns the client Id of a rental object
        """
        return self.__car_model

    @property
    def get_rented_date(self):
        """
        returns the date of a rental object
        """
        return self.__rented_date

    @property
    def get_returned_date(self):
        """
        returns the returned date of a rental object
        """
        return self.__returned_date


def read_text_file(file_name):
    result = []
    try:
        f = open(file_name, "r")
        line = f.readline().strip()
        while len(line) > 0:
            line = line.split(";")
            result.append(Rental(int(line[0]), line[1], line[2], line[3], line[4]))
            line = f.readline().strip()
        f.close()
    except IOError as e:
        """
            Here we 'log' the error, and throw it to the outer layers 
        """
        print("An error occured - " + str(e))
        raise e

    return result
