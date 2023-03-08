import unittest
from datetime import date
from src.domain.movie import Movie
from src.repository.utilities import IterableData,filter_method,sorting_algorithm
from src.repository.movieRepository import MovieRepository
from src.repository.repository_exception import RepositoryException
from src.repository.undoRepository import UndoRepository
from src.services.movieService import MovieService
from src.services.rentalService import RentalService
from src.services.clientService import ClientService
from src.repository.clientRepository import ClientRepository
from src.repository.rentalRepository import RentalRepository


class Test_for_the_utilities(unittest.TestCase):
    def setUp(self) -> None:
        """
        Runs before every test method
        """
        self._functions = IterableData()

    def tearDown(self) -> None:
        """
        Runs after every test method
        """
        pass

    def test__append__valid_movie__movie_is_added_to_the_list(self):
        self._functions.append(Movie('24', 'Frozen (2013)', "A", "b"))
        self.assertEqual(len(self._functions._current_list), 1)

    def test__remove__valid_movie__movie_is_removed(self):
        self._functions.append(Movie('24', 'Frozen (2013)', "A", "b"))
        self._functions.remove(0)
        self.assertEqual(len(self._functions._current_list), 0)

    def test__filter_method__valid_list__new_filtered_list(self):
        self._functions.append(Movie('24', 'Frozen (2013)', "A", "b"))
        self._functions.append(Movie('25', 'F', "A", "b"))
        new_list = filter_method(self._functions._current_list, lambda x: int(x.get_movieId) == int(25))
        self.assertEqual(len(new_list), 1)

    def test__sorting_algorithm__valid_list__sorted_list(self):
        list_to_sort = [1, 87, 5, 21]
        new_list = sorting_algorithm(list_to_sort, lambda first, second: first > second)
        self.assertEqual(new_list, [1, 5, 21, 87])


class Test_for_movie_repository(unittest.TestCase):

    def setUp(self) -> None:
        """
        Runs before every test method
        """
        self._new_repository = MovieRepository()

    def tearDown(self) -> None:
        """
        Runs after every test method
        """
        pass

    def test__add_new_movie__valid_movie__movie_is_added_to_the_list(self):
        self._new_repository.add_new_movie('24', 'Frozen (2013)', "A", "b")
        self.assertEqual(len(self._new_repository._list_of_movie), 1)

    def test__add_new_movie___id_is_a_string__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_repository.add_new_movie('m', 'Frozen (2013)', "A", "b")

    def test__add_new_movie__id_is_not_unique__throws_exception(self):
        self._new_repository.add_new_movie('4', 'Frozen (2013)', "A", "b")
        with self.assertRaises(RepositoryException):
            self._new_repository.add_new_movie('4', 'Frozen (2013)', "A", "b")

    def test__add_new_movie__title_is_a_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_repository.add_new_movie('4', '7', "A", "b")

    def test__add_new_movie__description_is_a_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_repository.add_new_movie('4', 'm', "2", "b")

    def test__add_new_movie__genre_is_a_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_repository.add_new_movie('4', 'a', "b", "7")

    def test__remove_movie__valid_movie__movie_is_removed(self):
        self._new_repository.add_new_movie("4", "m", "n", "o")
        self._new_repository.remove_movie(4)
        self.assertEqual(len(self._new_repository._list_of_movie), 0)

    def test__remove_movie__id_does_not_exist__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_repository.remove_movie(0)

    def test__find_movie_in_movies_list__id_of_movie_is_in_list__returns_the_position_in_the_list(self):
        self._new_repository.add_new_movie(5, "m", "c", "d")
        self._new_repository.add_new_movie(6, "m", "c", "d")
        self.assertEqual(self._new_repository.find_movie_in_movies_list(6), 1)

    def test__find_movie_in_list__movie_is_not_in_list__returns_false(self):
        self.assertEqual(self._new_repository.find_movie_in_movies_list(100), -1)

    def test__update_movie__description_is_a_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_repository.update_movie("4", "m", "4", "m")

    def test__update_movie__genre_is_a_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_repository.update_movie("4", "m", "n", "6")

    def test__display_movies__valid_existing_movie_list__returns_the_list_with_the_movies(self):
        self.assertEqual(self._new_repository.display_movies(), '')
        self._new_repository.add_new_movie("4", "m", "n", "p")
        self.assertEqual(self._new_repository.display_movies(), ' Movie Id: 4 Title: m Description: n Genre: p'+'\n')

    def test__search_for_the_given_id_in_movies_list__movie_id_in_movies_list__returns_the_list_of_the_movies(self):
        self.assertEqual(self._new_repository.search_for_the_given_id_in_movies_list(6), '')
        self._new_repository.add_new_movie("4", "m", "n", "p")
        self.assertEqual(self._new_repository.search_for_the_given_id_in_movies_list(4), ' Movie Id: 4 Title: m Description: n Genre: p'+'\n')

    def test__search_for_the_given_title_in_movies_list__title_is_in_list__returns_list_of_the_movies(self):
        self.assertEqual(self._new_repository.search_the_given_title_in_movies_list("k"), '')
        self._new_repository.add_new_movie("7", "a", "b", "c")
        self.assertEqual(self._new_repository.search_the_given_title_in_movies_list("a"), ' Movie Id: 7 Title: a Description: b Genre: c' + '\n')

    def test__determine_the_list_for_the_most_rented_movies__existing_valid_movies_list__is_true(self):
        self._new_repository.add_new_movie("7", "a", "b", "c")
        self.assertEqual(self._new_repository.determine_the_list_for_the_most_rented_movies({7: 5}),' Movie Id: 7 Title: a Description: b Genre: c' + '\n' )


class Test_for_client_repository(unittest.TestCase):

    def setUp(self) -> None:
        """
        Runs before every test method
        """
        self._new_client_repository = ClientRepository()

    def tearDown(self) -> None:
        """
        Runs after every test method
        """
        pass

    def test__add_new_client__id_is_a_string_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_client_repository.add_new_client('m', 'n')

    def test__add_new_client__id_is_not_unique__throws_exception(self):
        self._new_client_repository.add_new_client("5", "m")
        with self.assertRaises(RepositoryException):
            self._new_client_repository.add_new_client("5", "n")

    def test__add_new_client__id_is_a_negative_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_client_repository.add_new_client("-1", "m")

    def test__remove_client__movie_id_exists_in_list__list_with_removed_element(self):
        self._new_client_repository.add_new_client("5", "m")
        self._new_client_repository.remove_client(5)
        self.assertEqual(len(self._new_client_repository._list_of_clients), 0)

    def test__remove_client__id_is_not_in_list__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self._new_client_repository.remove_client(5)

    def test__update_client__name_is_a_number__throws_exception(self):
        self._new_client_repository.add_new_client("5", "m")
        with self.assertRaises(RepositoryException):
            self._new_client_repository.update_client("5", "5")

    def test__update_client__no_added_name__throws_exception(self):
        self._new_client_repository.add_new_client("5", "n")
        with self.assertRaises(RepositoryException):
            self._new_client_repository.update_client("5", "")

    def test__find_client_in_clients_list__client_is_in_clients_list__returns_its_position_in_list(self):
        self._new_client_repository.add_new_client("5", "m")
        self.assertEqual(self._new_client_repository.find_client_in_clients_list(5), 0)

    def test__find_client_in_clients_list__id_is_not_in_list__return_false(self):
        self.assertEqual(self._new_client_repository.find_client_in_clients_list(7), -1)

    def test__search_based_on_the_id_in_clients_list__client_is_in_list__returns_the_string(self):
        self.assertEqual(self._new_client_repository.search_based_on_the_id_in_clients_list(6), '')
        self._new_client_repository.add_new_client("4", "m")
        self.assertEqual(self._new_client_repository.search_based_on_the_id_in_clients_list(4), '  Client Id: 4 Name: m'+ '\n')

    def test__search_based_on_the_name__id_in_list__returns_the_list_of_clients_in_a_string(self):
        self.assertEqual(self._new_client_repository.search_based_on_the_name("a"), '')
        self._new_client_repository.add_new_client("2", "n")
        self.assertEqual(self._new_client_repository.search_based_on_the_name("n"), '  Client Id: 2 Name: n' + '\n')

    def test__determine_the_list_for_the_most_active_clients__returns_string_with_the_clients_list(self):
        self._new_client_repository.add_new_client("7", "a")
        self.assertEqual(self._new_client_repository.determine_the_list_for_the_most_active_clients({"7": "3"}), '  Client Id: 7 Name: a' + '\n')


class Test_for_rental_repository(unittest.TestCase):

    def setUp(self) -> None:
        """
        Runs before every test method
        """
        self.new_rental_repository = RentalRepository()

    def tearDown(self) -> None:
        """
        Runs after every test method
        """
        pass

    def test__add_new_rental__rental_data_is_valid__adds_rental_to_list(self):
        self.new_rental_repository.add_new_rental("1", "20", "5", "2021-4-8", "2021-6-9", None)
        self.assertEqual(len(self.new_rental_repository._list_of_rental), 1)

    def test__add_new_rental__id_is_a_string__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self.new_rental_repository.add_new_rental("m", "20", "5", "2021-4-8", "2021-6-9", None)

    def test__add_new_rental__id_of_the_movie_is_a_negative_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self.new_rental_repository.add_new_rental("20", "-20", "5", "2021-4-8", "2021-6-9", None)

    def test__add_new_rental__id_of_the_client_is_a_negative_number__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self.new_rental_repository.add_new_rental("20", "20", "-5", "2021-4-8", "2021-6-9", None)

    def test__add_new_rental__invalid_rent_date__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self.new_rental_repository.add_new_rental("20", "20", "5", "-1", "2021-6-7", None)

    def test__add_new_rental__invalid_due_date__throws_exception(self):
        with self.assertRaises(RepositoryException):
            self.new_rental_repository.add_new_rental("20", "20", "5", "2021-6-5", "-2", None)

    def test__find_the_id_in_rental_in_list__id_is_in_list__returns_position_in_list(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", "2021-4-8", "2021-6-9", None)
        self.assertEqual(self.new_rental_repository.find_the_id_of_the_rental_in_list(7), 0)

    def test__find_the_id_in_rental_in_list__id_not_in_list__is_false(self):
        self.assertEqual(self.new_rental_repository.find_the_id_of_the_rental_in_list(7), -1)

    def test__compare_the_dates_for_the_rent__valid_data__returns_true(self):
        self.assertEqual(self.new_rental_repository.compare_the_dates_for_the_rent([2021, 2, 5]), True)

    def test__compare_the_dates_for_the_rent__invalid_data__returns_false(self):
        self.assertEqual(self.new_rental_repository.compare_the_dates_for_the_rent([2021, 12, 5]), False)

    def test__get_date__valid_date_returns_data(self):
        self.assertEqual(self.new_rental_repository.get_date("2021-12-1"), ['2021', '12', '1'])

    def test__search_the_movie_in_rental_list__returns_true(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", "2021-4-8", "2021-6-9", None)
        self.assertEqual(self.new_rental_repository.search_the_movie_in_rental_list(1), 0)

    def test__search_the_movie_in_rental_list__returns_false(self):
        self.assertEqual(self.new_rental_repository.search_the_movie_in_rental_list(8), -1)

    def test__check_the_availability_of_the_movie__is_true(self):
        self.new_rental_repository.add_new_rental("7", "7", "3", "2021-4-8", "2021-6-9", "2021-6-8")
        self.new_rental_repository.add_new_rental("8", "20", "3", "2021-4-8", "2021-6-9", None)
        self.assertEqual(self.new_rental_repository.check_the_availability_of_the_movie("1"), True)

    def test__check_the_availability_of_the_movie__is_false(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", "2021-4-8", "2021-6-9", None)
        self.assertEqual(self.new_rental_repository.check_the_availability_of_the_movie("1"), False)

    def test__check_if_a_client_is_able_to_rent_a_movie__returns_true(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", [2021, 4, 8], [2021, 6, 9], None)
        self.assertEqual(self.new_rental_repository.check_if_a_client_has_the_right_to_rent_a_movie(4), True)

    def test__check_if_a_client_is_able_to_rent_a_movie__returns_false(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", [2021, 4, 8], [2021, 6, 9], None)
        with self.assertRaises(RepositoryException):
            self.new_rental_repository.check_if_a_client_has_the_right_to_rent_a_movie(3)

    def test__determine_the_numbers_of_days_rented_current_movie__returns_days(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", [2021, 4, 8], [2021, 6, 9], None)
        self.assertEqual(self.new_rental_repository.determine_the_numbers_of_days_rented_current_movie(1), 239)

    def test__movies_sorted_by_rented_days__returns_list_with_the_rented_days(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", [2021, 4, 8], [2021, 6, 9], None)
        self.assertEqual(self.new_rental_repository.movies_sorted_by_rented_days(), [("1", 239)])

    def test__sorted_clients_by_rented_days_they_have__returns_clients_and_the_days(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", [2021, 4, 8], [2021, 6, 9], None)
        self.assertEqual(self.new_rental_repository.clients_sorted_by_rented_days_they_have(), [("3", 239)])

    def test__sorted_list_for_currently_rented_movies_which_due_date_expired__returns_movies(self):
        self.new_rental_repository.add_new_rental("7", "1", "3", [2021, 4, 8], [2021, 6, 9], None)
        self.new_rental_repository.add_new_rental("8", "20", "4", [2021, 4, 9], [2021, 6, 9], None)
        self.assertEqual(self.new_rental_repository.sorted_list_for_currently_rented_movies_which_due_date_expired(), [("1", 239), ("20", 238)])


class Test_for_undo_repository(unittest.TestCase):

    def setUp(self) -> None:
        """
        Runs before every test method
        """
        self._new_undo_repository = UndoRepository()
        self._movie_service = MovieService(MovieRepository())
        self._client_service = ClientService(ClientRepository())
        self._rental_service = RentalService(RentalRepository())

    def tearDown(self) -> None:
        """
        Runs after every test method
        """
        pass

    def test__remove_movie__valid_movie__command_for_undo_is_added_to_the_undo_repository_list(self):
        self._new_undo_repository.remove_movie('24', 'Frozen', "A", "b")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test_add_movie__valid_movie__command_for_undo_is_added_to_undo_repository_list(self):
        self._new_undo_repository.add_movie('5', "m", "c", "d")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test__update_movie__valid_movie__command_for_undo_is_added_to_undo_repository_list(self):
        self._new_undo_repository.update_movie('15', "m", "c", "d")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test__remove_client__valid_client__command_for_undo_is_added_to_undo_repository_list(self):
        self._new_undo_repository.remove_client("5", "m")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test__add_client__valid_client__command_for_undo_is_added_to_undo_repository_list(self):
        self._new_undo_repository.add_client("1", "a")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test__update_client__valid_client__command_is_added_to_undo_repository_list(self):
        self._new_undo_repository.update_client("1", "b")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test__remove_rental__valid_rental__command_for_undo_is_added_to_undo_repository_list(self):
        self._new_undo_repository.remove_rental("1", "20", "5", "2021-4-8", "2021-6-9", None)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test__return_movie__valid_movie__the_command_for_undo_is_added_to_the_list(self):
        self._new_undo_repository.return_movie("20")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)

    def test__undo__valid_remove_command__removes_the_added_movie(self):
        self._movie_service.add_movie('24', 'Frozen (2013)', "A", "b")
        self._new_undo_repository.remove_movie('24', 'Frozen', "A", "b")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)

    def test__undo__valid_add_command__adds_the_removed_movie(self):
        self._movie_service.add_movie('5', "m", "c", "d")
        self._movie_service.remove_the_movie_with_given_id('5')
        self._new_undo_repository.add_movie('5', "m", "c", "d")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)

    def test__undo__valid_update_command__updates_the_updated_movie_back_to_the_old_data(self):
        self._movie_service.add_movie('7', "m", "c", "d")
        self._movie_service.add_movie('8', "m", "c", "d")
        self._movie_service.update('7', "a", "c", "b")
        self._new_undo_repository.update_movie('5', "m", "c", "d")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)

    def test__undo__valid_remove_command__removes_the_added_client(self):
        self._client_service.add_client('15', 'm')
        self._new_undo_repository.remove_client('15', "b")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)

    def test__undo__valid_add_command__adds_the_client_back_to_the_list(self):
        self._client_service.add_client('15', 'm')
        self._client_service.remove_the_client_with_given_id(15)
        self._new_undo_repository.add_client('15', "b")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)

    def test__undo__valid_update_command__updates_the_updated_client_back_with_the_old_data(self):
        self._client_service.add_client('15', 'm')
        self._client_service.add_client('4', 'm')
        self._client_service.update('15', 'c')
        self._new_undo_repository.update_client('5', "m")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)

    def test__redo__valid_remove_command__removes_the_movie_again(self):
        self._new_undo_repository.add_movie('5', 'm', "c", "d")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self._new_undo_repository.redo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 0)

    def test__redo__valid_add_command__adds_back_the_movie_to_the_list(self):
        self._movie_service.add_movie('5', "m", "c", "d")
        self._new_undo_repository.remove_movie('5', 'm', "c", "d")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self._new_undo_repository.redo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 0)

    def test__redo__valid_update_command__updates_back_the_movie_to_the_new_data(self):
        self._movie_service.add_movie('5', "m", "c", "d")
        self._movie_service.add_movie('8', "m", "c", "d")
        self._movie_service.update('7', "a", "c", "b")
        self._new_undo_repository.update_movie('5', "m", "c", "d")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 1)
        self._new_undo_repository.redo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 0)

    def test__redo__valid_remove_command__removes_the_client_again(self):
        self._client_service.add_client('15', 'm')
        self._client_service.remove_the_client_with_given_id(15)
        self._new_undo_repository.add_client('15', "b")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 1)
        self._new_undo_repository.redo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 0)

    def test__redo__valid_add_command__adds_back_the_client_to_the_list(self):
        self._client_service.add_client('15', 'm')
        self._new_undo_repository.remove_client('15', "b")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 1)
        self._new_undo_repository.redo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 0)

    def test__redo__valid_update_command__updates_back_the_client_to_the_new_data(self):
        self._client_service.add_client('15', 'm')
        self._client_service.add_client('4', 'm')
        self._client_service.update('15', 'c')
        self._new_undo_repository.update_client('5', "m")
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 1)
        self._new_undo_repository.redo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 0)

    def test__undo__valid_remove_command__remove_the_new_added_rental(self):
        self._rental_service.add_rental_to_the_list("1", "20", "5", "2021-4-8", "2021-6-9", None)
        self._new_undo_repository.remove_rental("1", "20", "5", "2021-4-8", "2021-6-9", None)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 1)

    def test__undo__valid_return_command__cancels_the_returned_movie(self):
        self._rental_service.add_rental_to_the_list("1", "20", "5", "2021-4-8", "2021-6-9", None)
        self._new_undo_repository.return_movie("20")
        self.assertEqual(len(self._new_undo_repository._undo_repository), 1)
        self._new_undo_repository.undo(self._movie_service, self._client_service, self._rental_service)
        self.assertEqual(len(self._new_undo_repository._undo_repository), 0)
        self.assertEqual(len(self._new_undo_repository._redo_repository), 1)
