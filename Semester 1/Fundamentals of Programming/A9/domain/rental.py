class Rental:
    def __init__(self, rental_id, movie_id, client_id, rented_date, due_date, returned_date):
        self.__rental_id = rental_id
        self.__movie_id = movie_id
        self.__client_id = client_id
        self.__rented_date = rented_date
        self.__due_date = due_date
        self.__returned_date = returned_date

    @property
    def get_rental_id(self):
        """
        returns the rental Id of a rental object
        """
        return self.__rental_id

    @property
    def get_movie_id(self):
        """
        returns the movie Id of a rental object
        """
        return self.__movie_id

    @property
    def get_client_id(self):
        """
        returns the client Id of a rental object
        """
        return self.__client_id

    @property
    def get_rented_date(self):
        """
        returns the date of a rental object
        """
        return self.__rented_date

    @property
    def get_due_date(self):
        """
        returns the due date of a rental object
        """
        return self.__due_date

    @property
    def get_returned_date(self):
        """
        returns the returned date of a rental object
        """
        return self.__returned_date

    def set_returned_date(self, date):
        self.__returned_date = date

    def __str__(self):
        return " Rental: " + str(self.__rental_id) + " Movie ID:" + str(self.__movie_id) + " Client ID: " +\
               str(self.__client_id) + " Rented date: " + str(self.__rented_date) + " Due date: " +\
               str(self.__due_date) + " Returned date: " + str(self.__returned_date)

    @staticmethod
    def from_line(line):
        parts = line.split(",")
        rental_id = parts[0]
        movie_id = parts[1]
        client_id = parts[2]
        parts[3] = parts[3][2:]

        rented_date_year = parts[3].strip("'")
        rented_date_month = parts[4][1:].strip("'")
        rented_date_day = parts[5][1:][:-1].strip("'")
        rented_date = [rented_date_year, rented_date_month, rented_date_day]

        due_date_year = parts[6][1:].strip("'")
        due_date_month = parts[7][1:].strip("'")
        due_date_day = parts[8][1:][:-1].strip("'")
        due_date = [due_date_year, due_date_month, due_date_day]

        if parts[9] != "None":
            returned_date_year = parts[9][1:].strip("'")
            returned_date_month = parts[10][1:].strip("'")
            returned_date_day = parts[11][1:][:-1].strip("'")
            returned_date = [returned_date_year, returned_date_month, returned_date_day]
        else:
            returned_date = None
        return [rental_id, movie_id, client_id, rented_date, due_date, returned_date]

    @staticmethod
    def to_line(rental):
        line = f"{str(rental.__rental_id)},{str(rental.__movie_id)},{str(rental.__client_id)},{str(rental.__rented_date)},{str(rental.__due_date)},{str(rental.__returned_date)}"
        return line

    def to_dictionary(self):
        return {"rental_id": self.__rental_id, "movie_id": self.__movie_id,  "client_id": self.__client_id, "rented_date": self.__rented_date, "due_date": self.__due_date, "returned_date": self.__returned_date}


def return_the_getters_is_true():
    first = Rental("1", "2", "3", "4", "5", "6")
    assert first.get_rental_id == '1'
    assert first.get_movie_id == '2'
    assert first.get_client_id == '3'
    assert first.get_rented_date == '4'
    assert first.get_due_date == '5'
    assert first.get_returned_date == '6'

    second = Rental("1", "2", "3", "4", "5", "6")
    assert second.get_rental_id == '1'
    assert second.get_movie_id == '2'
    assert second.get_client_id == '3'
    assert second.get_rented_date == '4'
    assert second.get_due_date == '5'
    assert second.get_returned_date == '6'

    third = Rental("1", "2", "3", "4", "5", "6")
    assert third.get_rental_id == '1'
    assert third.get_movie_id == '2'
    assert third.get_client_id == '3'
    assert third.get_rented_date == '4'
    assert third.get_due_date == '5'
    assert third.get_returned_date == '6'

    fourth = Rental("1", "2", "3", "4", "5", "6")
    assert fourth.get_rental_id == '1'
    assert fourth.get_movie_id == '2'
    assert fourth.get_client_id == '3'
    assert fourth.get_rented_date == '4'
    assert fourth.get_due_date == '5'
    assert fourth.get_returned_date == '6'

    fifth = Rental("1", "2", "3", "4", "5", "6")
    assert fifth.get_rental_id == '1'
    assert fifth.get_movie_id == '2'
    assert fifth.get_client_id == '3'
    assert fifth.get_rented_date == '4'
    assert fifth.get_due_date == '5'
    assert fifth.get_returned_date == '6'


return_the_getters_is_true()