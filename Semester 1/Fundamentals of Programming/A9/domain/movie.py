class Movie:
    def __init__(self, movie_id, title, description, genre):
        self.__movie_id = movie_id
        self.__title = title
        self.__description = description
        self.__genre = genre

    @property
    def get_movieId(self):
        """
        returns the Id of the movie object
        """
        return self.__movie_id

    @property
    def get_title(self):
        """
        returns the title of the movie object
        """
        return self.__title

    @property
    def get_description(self):
        """
        returns the description of the movie object
        """
        return self.__description

    @property
    def get_genre(self):
        """
        returns the genre of the movie object
        """
        return self.__genre

    def printMovie(self):
        return ' Movie Id: ' + str(self.__movie_id) + ' Title: ' + str(self.__title) + ' Description: ' + str(self.__description) + ' Genre: ' + str(
            self.__genre) + '\n'

    def __str__(self):
        return " Movie ID: " + str(self.__movie_id)+" Title: " + str(self.__title) + " Description: " +\
               str(self.__description) + " Genre: " + str(self.__genre)

    def set_id(self, new_id):
        self.__movie_id = new_id

    def set_title(self, movie_title):
        self.__title = movie_title

    def set_description(self, new_description):
        self.__description = new_description

    def set_genre(self, new_genre):
        self.__genre = new_genre

    @staticmethod
    def from_line(line):
        parts = line.split(",")
        movie_id = parts[0]
        title = parts[1]
        description = parts[2]
        genre = parts[3]
        return [movie_id, title, description, genre]

    @staticmethod
    def to_line(movie):
        line = f"{str(movie.__movie_id)},{movie.__title},{str(movie.__description)},{str(movie.__genre)}"
        return line

    def to_dictionary(self):
        return {"movie_id": self.__movie_id, "movie_title": self.__title,  "movie_description": self.__description, "movie_genre": self.__genre}


def return_the_getters_is_true():
    first_movie = Movie(1, 'n', 'o', 'p')
    second_movie = Movie(2, 'a', 'b', 'c')
    third_movie = Movie(3, 'd', 'e', 'f')
    fourth_movie = Movie(4, 'g', 'h', 'i')
    fifth_movie = Movie(5, 'j', 'k', 'l')

    assert first_movie.get_movieId == 1
    assert first_movie.get_title == 'n'
    assert first_movie.get_description == 'o'
    assert first_movie.get_genre == 'p'

    assert second_movie.get_movieId == 2
    assert second_movie.get_title == 'a'
    assert second_movie.get_description == 'b'
    assert second_movie.get_genre == 'c'

    assert third_movie.get_movieId == 3
    assert third_movie.get_title == 'd'
    assert third_movie.get_description == 'e'
    assert third_movie.get_genre == 'f'

    assert fourth_movie.get_movieId == 4
    assert fourth_movie.get_title == 'g'
    assert fourth_movie.get_description == 'h'
    assert fourth_movie.get_genre == 'i'

    assert fifth_movie.get_movieId == 5
    assert fifth_movie.get_title == 'j'
    assert fifth_movie.get_description == 'k'
    assert fifth_movie.get_genre == 'l'


return_the_getters_is_true()
