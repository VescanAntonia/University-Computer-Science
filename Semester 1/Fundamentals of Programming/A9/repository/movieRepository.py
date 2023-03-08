from src.repository.repository_exception import RepositoryException
from random import choice
from src.domain.movie import Movie
import pickle
import json


class MovieRepository:
    def __init__(self):
        self._list_of_movie = []

    def add_new_movie(self, new_movie_id, new_movie_title, new_movie_description, new_movie_genre):
        """
        :param new_movie_id: the id of the new movie to be added
        :param new_movie_title: the title of the new movie to be added
        :param new_movie_description: the description of the new movie to be added
        :param new_movie_genre: the genre of the new movie to be added
        :return: adds the new movie tot the movies.bin list
        """
        new_movie = Movie(new_movie_id, new_movie_title, new_movie_description, new_movie_genre)
        self.check_if_movie_is_valid(new_movie)
        for movie in self._list_of_movie:
            if int(movie.get_movieId) == int(new_movie.get_movieId):
                raise RepositoryException("Id of the movie is already present.")
        self._list_of_movie.append(new_movie)

    def remove_movie(self, movie_Id):
        """
        :param movie_Id: the id of the movie to be removed
        :return: removes the movie for the given id
        """
        position = self.find_movie_in_movies_list(movie_Id)
        if position == -1:
            raise RepositoryException("Movie with the given id does not exist.")
        self._list_of_movie.pop(position)

    def find_movie_in_movies_list(self, movie_id):
        """
        :param movie_id: the id of the movie that needs to be found
        :return: the position of the movie in list or -1 if it is not in the list
        """
        index = 0
        for movie in self._list_of_movie:
            if int(movie.get_movieId) == int(movie_id):
                return index
            index += 1

        return -1

    def display_movies(self):
        """
        :return: the string with the movies.bin to be displayed
        """
        movie_list_to_display = ''
        for movie in self._list_of_movie:
            movie_list_to_display += movie.printMovie()
        return movie_list_to_display

    def update_movie(self, movie_id, users_given_movie_title, users_given_movie_description, users_given_movie_genre):
        """
        :param movie_id: the id of the movie to be updated
        :param users_given_movie_title: the new title the movie should have
        :param users_given_movie_description: the new description the movie should have
        :param users_given_movie_genre: the new genre the movie should have
        :return: the updated movie
        """
        new_movie = Movie(movie_id, users_given_movie_title, users_given_movie_description, users_given_movie_genre)
        self.check_if_movie_is_valid(new_movie)
        position = self.find_movie_id_movies_list(new_movie.get_movieId)
        self._list_of_movie[position].set_title(new_movie.get_title)
        self._list_of_movie[position].set_description(new_movie.get_description)
        self._list_of_movie[position].set_genre(new_movie.get_genre)

    def search_for_the_given_id_in_movies_list(self, given_id_for_the_search):
        """
        :param given_id_for_the_search: the id of the movie that should be found
        :return: the movie for the given id
        """
        list_with_found_movies_based_on_id = ''
        for movie in self._list_of_movie:
            if int(movie.get_movieId) == int(given_id_for_the_search):
                list_with_found_movies_based_on_id += movie.printMovie()
        return list_with_found_movies_based_on_id

    def search_the_given_title_in_movies_list(self, given_word_to_search_for_title):
        """
        :param given_word_to_search_for_title: the given word that need to match the title of the movie
        :return: the string containing all the movies.bin which title match with the given word
        """
        list_found_movies_based_on_title = ''
        for movie_for_search_title in self._list_of_movie:
            if given_word_to_search_for_title.lower() in movie_for_search_title.get_title.lower():
                list_found_movies_based_on_title += movie_for_search_title.printMovie()
        return list_found_movies_based_on_title

    def search_the_given_description_in_movies_list(self, given_word_to_search_for_description):
        """
        :param given_word_to_search_for_description: the given word that need to match the description of the movie
        :return: the string containing all the movies.bin which description match with the given word
        """
        list_found_movies_based_on_description = ''
        for movie_for_search_description in self._list_of_movie:
            if given_word_to_search_for_description.lower() in movie_for_search_description.get_description.lower():
                list_found_movies_based_on_description += movie_for_search_description.printMovie()
        return list_found_movies_based_on_description

    def search_for_the_given_genre_movies_list(self, given_word_to_search_for_genre):
        """

        :param given_word_to_search_for_genre: the given word that need to match the genre of the movie
        :return: the string containing all the movies.bin which genre match with the given word
        """
        list_found_movies_based_on_genre = ''
        for movie_for_search_genre in self._list_of_movie:
            if given_word_to_search_for_genre.lower() in movie_for_search_genre.get_genre.lower():
                list_found_movies_based_on_genre += movie_for_search_genre.printMovie()
        return list_found_movies_based_on_genre

    def determine_the_list_for_the_most_rented_movies(self, list_of_the_sorted_rented_days):
        """
        :param list_of_the_sorted_rented_days: a list containing the id of the movies.bin and the corresponding number of rented days
        :return: a string containing the most rented movies.bin
        """
        list_of_the_sorted_rented_days = dict(list_of_the_sorted_rented_days)
        movies_sorted_list_rented_days = ''
        new_list_with_the_keys_movies_id = list(list_of_the_sorted_rented_days.keys())
        for element in new_list_with_the_keys_movies_id:
            movie_index_in_list = self.find_movie_in_movies_list(element)
            movies_sorted_list_rented_days += self._list_of_movie[movie_index_in_list].printMovie()
        return movies_sorted_list_rented_days

    def find_movie_id_movies_list(self, movie_id):
        """
        :param movie_id: the id of the movie that needs to be found
        :return: the position of the movie in list or -1 if it is not in the list
        """
        index = 1
        for movie in self._list_of_movie:
            if int(movie.get_movieId) == int(movie_id):
                return index
            index += 1

        return -1

    def check_if_movie_is_valid(self, movie):
        """
        :param movie: a given movie
        :return: checks if the movie is valid, meaning the id is a positive number and the title,genre and description
            are strings
        """
        if not str(movie.get_movieId).isnumeric():
            raise RepositoryException("  Id must be a number!")
        if int(movie.get_movieId) < 0:
            raise RepositoryException("  Id cannot be a negative number! ")
        if str(movie.get_title).isnumeric():
            raise RepositoryException("  Movie title cannot be a number!")
        if movie.get_title == '':
            raise RepositoryException("  No title has been added!")
        if str(movie.get_description).isnumeric():
            raise RepositoryException("  Movie description cannot be a number!")
        if movie.get_description == '':
            raise RepositoryException("  No description has been added!")
        if str(movie.get_genre).isnumeric():
            raise RepositoryException("  Movie genre cannot be a number!")
        if movie.get_genre == '':
            raise RepositoryException("  No genre has been added!")
        return True

    def set_list(self, data):
        i = 0
        k = len(data)
        while i < k:
            stud = data[i]
            self._list_of_movie.append(stud)
            i += 1
        return self._list_of_movie

    def __getitem__(self, item):
        return self._list_of_movie[item]

    def __len__(self):
        return len(self._list_of_movie)

    def get_the_data_for_movie_updated_to_undo(self, movie_given_id):
        movie_position_in_list = self.find_movie_in_movies_list(movie_given_id)+1
        current_movie = self._list_of_movie[movie_position_in_list]
        return movie_given_id, current_movie.get_title, current_movie.get_description, current_movie.get_genre

    def get_all_movies(self):
        """
        :return: generates randomly the list of the movies.bin
        """
        n = 20
        for i in range(n):
            chosen_movie = choice(list_of_available_movies)
            self.add_new_movie(i+1, chosen_movie[1], chosen_movie[2], chosen_movie[3])
            list_of_available_movies.remove(chosen_movie)
        return self._list_of_movie

    def get_all(self):
        return self._list_of_movie


list_of_available_movies = [('1', 'Frozen', 'Anna and her sister, queen Elsa, get through challenges and meet '
                                                   'new friends, to save the kingdom from not only Hans, but from forever winter.', 'Fantasy'), ('2', 'Titanic', 'Titanic is an epic, action-packed romance set against the ill-fated maiden voyage of the R.M.S. Titanic', 'Drama'), ("3", "Gone with the wind", "In 1861, Scarlett O'Hara, the headstrong sixteen-year-old daughter of wealthy Georgia plantation-owner Gerald O'Hara, is sick of hearing talk about going to war with the North.", "Romance"), ("4", "The Last Letter from Your Lover", "In the mid-1960s wealthy socialite Jennifer Stirling suffers from memory loss after a car accident. Unable to remember much of her life before or connect with her husband, businessman Laurence, Jennifer is intrigued by a letter she finds between J and Boot. ", "romantic drama"), ("5", "The Tomorrow War", "In December 2022, biology teacher and former Green Beret, Dan Forester, fails to get a job at the Army Research Laboratory. During the broadcast of the World Cup, soldiers from the year 2051 arrive to warn that, in their time, humanity is on the brink of extinction due to a war with alien invaders", "Science fiction"), ("6", "'Avengers: Age of Ultron", "Tony Stark creates the Ultron Program to protect the world, but when the peacekeeping program becomes hostile, The Avengers go into action to try and defeat a virtually impossible enemy together.", "Science Fiction"),
                            ("7", "Jurassic World", "22 years after the original Jurassic Park failed, the new park (also known as Jurassic World) is open for business.", "Science Fiction"), ("8", "Infinite", "In 1985 Mexico City, Heinrich Treadway tries to escape the authorities and a man, Bathurst. He and his associates, Abel and Leona speak about the Egg, which Treadway stole from Bathurst.", " Science Fiction, Action"), ("9", "Central Intelligence", "In 1996, star athlete Calvin The Golden Jet Joyner is being honored at his high school.", "Action, Comedy"),
                            ("10", "7 Prisoners", "18-year-old Mateus leaves the countryside in search for a job opportunity in a São Paulo junkyard", "Drama"), ("11", "Avatar", "When his brother is killed in a robbery, paraplegic Marine Jake Sully decides to take his place in a mission on the distant world of Pandora.", "Science Fiction"), ("12", "Escape Plan", "Former prosecutor Ray Breslin is the founder and co-owner of Breslin-Clark, a security firm specializing in testing the security measures of supermax prisons.", "Action, Thriller"), ("13", "Without Remorse", "n Aleppo, a team of US Navy SEALs, including Senior Chief John Kelly, rescue a CIA operative taken hostage by a suspected pro-Assad paramilitary group. The situation escalates as the SEALs discover that the captors are actually Russian military.", "Action. Thriller"),
                            ("14", "The Turning", "Miss Jessel, the live-in tutor at the Fairchild Estate, flees the house in a panic and is attacked by a ragged man.", "Supernatural, Horror"), ("15", "Murder Mystery", "Nick Spitz is a New York police officer, and his wife Audrey is a hairdresser. Audrey wants to visit Europe, as Nick had promised at their wedding, but thinks they never will. ", "Comedy, mystery"), ("16", "Jupiter Ascending", "Earth and countless other planets were established by families of transhuman and alien royalty for the purpose of harvesting the resulting organisms to produce a youth serum for the elites on other planets.", "Space opera"),
                            ("17", "King Arthur: Legend of the Sword", "Mordred the warlock and his armies lay siege to Camelot. Uther Pendragon, king of the Britons, infiltrates Mordred's lair during the attack and beheads him with the help of a unique sword forged by Merlin, saving Camelot. Uther's brother Vortigern, who covets the throne, orchestrates a coup and sacrifices his wife Elsa to moat hags to become a Demon Knight. ", "Epic, fantasy, action, adventure"), ("18", "Snow White and the Huntsman", "While admiring a bright red rose blooming during a deep winter, Queen Eleanor of the kingdom of Tabor pricks her finger on one of its thorns. Drops of blood fall onto the snow, and she wishes for a daughter with skin white as snow, lips as red as blood, hair as black as a raven's wings, and a heart as strong as that rose.", "Fantasy"),
                            ("19", "The Imitation Game", "In 1951, two policemen, Nock and Staehl, investigate the mathematician Alan Turing after an apparent break-in at his home. During his interrogation by Nock, Turing tells of his time working at Bletchley Park during the Second World War.", "Historical drama"), ("20", "The Invisible Guest", "Spanish businessman Adrián Doria is out on bail after being arrested for the murder of his lover, Laura Vidal. His lawyer, Félix Leiva, hires prestigious defense attorney Virginia Goodman, who visits him at his apartment with the news that the prosecutor has found a witness who will be testifying in front of a judge soon", "Mystery thriller")]


class FileTextMovieRepository(MovieRepository):
    def __init__(self, file_path):
        self.__file_path = file_path
        self.__read_function = Movie.from_line
        self.__write_function = Movie.to_line
        super().__init__()

    def _read_all_from_file(self):
        with open(self.__file_path, 'r') as read_file:
            self._list_of_movie.clear()
            lines = read_file.readlines()
            for line in lines:
                line = line.strip()
                if len(line):
                    movie_id, movie_title, movie_description, movie_genre = self.__read_function(line)
                    super().add_new_movie(movie_id, movie_title, movie_description, movie_genre)

    def __write_all_to_file(self):
        with open(self.__file_path, 'w') as write_file:
            for movie in self._list_of_movie:
                write_file.write(self.__write_function(movie) + '\n')

    def __append_to_file(self, movie):
        with open(self.__file_path, 'a') as append_to_file:
            append_to_file.write("\n"+self.__write_function(movie))

    def add_new_movie(self, movie_id, movie_title, movie_description, movie_genre):
        self._read_all_from_file()
        super().add_new_movie(movie_id, movie_title, movie_description, movie_genre)
        self.__append_to_file(Movie(movie_id, movie_title, movie_description, movie_genre))

    def remove_movie(self, movie_id):
        self._read_all_from_file()
        super().remove_movie(movie_id)
        self.__write_all_to_file()

    def update_movie(self, movie_id, movie_title, movie_description, movie_genre):
        self._read_all_from_file()
        super().update_movie(movie_id, movie_title, movie_description, movie_genre)
        self.__write_all_to_file()

    def search_by_id(self, movie_id):
        self._read_all_from_file()
        return super().find_movie_id_movies_list(movie_id)

    def get_all_movies(self):
        self._read_all_from_file()
        return self._list_of_movie


class FileBinaryMovieRepository(MovieRepository):
    def __init__(self, file_path):
        self.__file_path = file_path
        self.__read_function = Movie.from_line
        self.__write_function = Movie.to_line
        super().__init__()

    def _read_all_from_file(self):
        with open(self.__file_path, 'rb') as read_file:
            self._list_of_movie.clear()
            try:
                self._list_of_movie = pickle.load(read_file)
            except EOFError:
                pass

    def __write_all_to_file(self):
        with open(self.__file_path, 'wb') as write_file:
            pickle.dump(self._list_of_movie, write_file)

    def __append_to_file(self, movie):
        with open(self.__file_path, 'wb') as append_file:
            pickle.dump(self._list_of_movie, append_file)

    def add_new_movie(self, movie_id, movie_title, movie_description, movie_genre):
        self._read_all_from_file()
        super().add_new_movie(movie_id, movie_title, movie_description, movie_genre)
        self.__append_to_file(Movie(movie_id, movie_title, movie_description, movie_genre))

    def remove_movie(self, movie_id):
        self._read_all_from_file()
        super().remove_movie(movie_id)
        self.__write_all_to_file()

    def update_movie(self, movie_id, movie_title, movie_description, movie_genre):
        self._read_all_from_file()
        super().update_movie(movie_id, movie_title, movie_description, movie_genre)
        self.__write_all_to_file()

    def search_by_id(self, movie_id):
        self._read_all_from_file()
        return super().find_movie_id_movies_list(movie_id)

    def get_all_movies(self):
        self._read_all_from_file()
        return self._list_of_movie


class FileJsonRepositoryMovie(MovieRepository):
    def __init__(self, file_path):
        self._file_path = file_path
        # self.__read_function = Client.from_line
        # self.__write_function = Client.to_line
        super().__init__()
        with open(self._file_path, 'r') as read_from_file:
            self._list_of_movie.clear()
            data = json.load(read_from_file)
        # file = open(self._file_path, "r")
        # data = json.load(self.)
        for current_data in data:
            self.add_new_movie(current_data["movie_id"], current_data["movie_title"], current_data["movie_description"],
                               current_data["movie_genre"])

    def __write_all_to_file(self):
        movies_to_be_added = []
        for movie in self._list_of_movie:
            movies_to_be_added.append(movie.to_dictionary())
        with open(self._file_path, "w") as f:
            f.write(json.dumps(movies_to_be_added))
        # file = open(self._file_path, "w")
        # json.dump([x.to_dictionary for x in self._list_of_movie], file, indent=4)
        # file.close()

    def add_new_movie(self, movie_id, movie_title, movie_description, movie_genre):
        super().add_new_movie(movie_id, movie_title, movie_description, movie_genre)
        self.__write_all_to_file()

    def remove_movie(self, movie_id):
        super().remove_movie(movie_id)
        self.__write_all_to_file()

    def update_movie(self, movie_id, movie_title, movie_description, movie_genre):
        super().update_movie(movie_id, movie_title, movie_description, movie_genre)
        self.__write_all_to_file()

    def get_all_movies(self):
        return self._list_of_movie


# class FileBinaryMovieRepository(MovieRepository):
#     def __init__(self, file_path, entity_from_line, entity_to_line):
#         super().__init__()
#         self.__file_path = file_path
#         self.__entity_from_line = entity_from_line
#         self.__entity_to_line = entity_to_line
#
#     def _append_to_file(self,  movie_id, movie_title, movie_description, movie_genre):
#         with open(self.__file_path, 'wb') as f:
#             pickle.dump(self._list_of_movie, f)
#
#     def _read_from_file(self):
#         with open(self.__file_path, 'rb') as f:
#             self._list_of_movie.clear()
#             try:
#                 self._list_of_movie = pickle.load(f)
#             except EOFError:
#                 pass
#
#     def _write_to_file(self):
#         with open(self.__file_path, 'wb') as f:
#             pickle.dump(self._list_of_movie, f)
#
#
#
#     def add_new_movie(self, movie_id, movie_title, movie_description, movie_genre):
#         self._read_from_file()
#         super().add_new_movie(movie_id, movie_title, movie_description, movie_genre)
#         self._append_to_file(movie_id, movie_title, movie_description, movie_genre)
#
#     def get_all_movies(self):
#         self._read_from_file()
#         return super().get_all()
#
#     def remove_movie(self, client_id):
#         self._read_from_file()
#         super().remove_movie(client_id)
#         self._write_to_file()
#
#     def update_movie(self,  movie_id, movie_title, movie_description, movie_genre):
#         self._read_from_file()
#         super().update_movie(movie_id, movie_title, movie_description, movie_genre)
#         self._write_to_file()
#
#     def search_by_key_word(self, key_word):
#         self._read_from_file()
#         return super().search_for_the_given_id_in_movies_list(key_word)

#
# class FileBinaryMovieRepository(MovieRepository):
#     def __init__(self, file_path):
#         super().__init__()
#         self.__file_path = file_path
#         self.__read_function = Movie.from_line
#         self.__write_function = Movie.to_line
#
#     def _read_all_from_file(self):
#         with open(self.__file_path, 'rb') as f:
#             self._list_of_movie.clear()
#             try:
#                 self._clients = pickle.load(f)
#             except EOFError:
#                 pass
#
#     def _write_all_to_file(self):
#         with open(self.__file_path, 'wb') as f:
#             pickle.dump(self._list_of_movie, f)
#
#     def _append_to_file(self, movie_id, movie_title, movie_description, movie_genre):
#         with open(self.__file_path, 'wb') as f:
#             pickle.dump(self._list_of_movie, f)
#
#     def add_new_movie(self, movie_id, movie_title, movie_description, movie_genre):
#         self._read_all_from_file()
#         super().add_new_movie(movie_id, movie_title, movie_description, movie_genre)
#         self._append_to_file(movie_id, movie_title, movie_description, movie_genre)
#
#     def remove_movie(self, movie_id):
#         self._read_all_from_file()
#         super().remove_movie(movie_id)
#         self._write_all_to_file()
#
#     def update_movie(self, movie_id, movie_title, movie_description, movie_genre):
#         self._read_all_from_file()
#         super().update_movie(movie_id, movie_title, movie_description, movie_genre)
#         self._write_all_to_file()
#
#     def search_by_id(self, movie_id):
#         self._read_all_from_file()
#         return super().find_movie_id_movies_list(movie_id)
#
#     def get_all_movies(self):
#         self._read_all_from_file()
#         return self._list_of_movie
