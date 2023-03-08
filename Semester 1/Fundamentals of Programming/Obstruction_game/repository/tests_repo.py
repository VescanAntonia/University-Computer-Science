import unittest
from repository import Repository


class Test_for_repository(unittest.TestCase):
    def setUp(self) -> None:
        """
        Runs before every test method
        """
        self._functions = Repository()

    def tearDown(self) -> None:
        """
        Runs after every test method
        """
        pass

    def test__initiate_the_field__valid_function__the_field_gets_its_initial_values(self):
        self._functions.initiate_the_field_for_game()
        self.assertEqual(len(self._functions._field), 6)

    def test__get_field_to_display__valid_data__fields_values_are_added_to_the_list(self):
        self._functions.initiate_the_field_for_game()
        field = self._functions.get_field_to_display()
        self.assertEqual(len(field), 36)

    def test_check_if_the_given_spot_is_empty__valid_coordinates_for_an_empty_spot__returns_true(self):
        self._functions.initiate_the_field_for_game()
        self.assertEqual(self._functions._field[0][0], -1)

    def test_check_if_the_given_spot_is_empty__valid_coordinates_for_a_nonempty_spot__returns_false(self):
        self._functions.initiate_the_field_for_game()
        self._functions._field[0][0] = 5
        self.assertEqual(self._functions._field[0][0], 5)

    def test__pick_the_position_and_mark_it_based_on_user_choice__valid_coordinates_for_spot__marks_the_spot_on_the_field(self):
        self._functions.initiate_the_field_for_game()
        self._functions.pick_the_position_and_mark_it_based_on_user_choice("a0", True)
        self.assertEqual(self._functions._field[0][0], 'o')

    def test__check_which_move_is_better_computer__list_of_the_spots__chooses_the_move_with_maximum_marked_spots(self):
        self._functions.initiate_the_field_for_game()
        move = self._functions.check_which_move_is_better_computer()
        self.assertEqual(move, "E4")

    def test__find_how_many_spaces_it_covers__valid_move__the_maximum_spots_the_move_can_mark(self):
        self._functions.initiate_the_field_for_game()
        number_of_spots = self._functions.find_how_many_spaces_it_covers("B2")
        self.assertEqual(number_of_spots, 4)
