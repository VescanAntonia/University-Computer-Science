import unittest
from repository.repository_achi import *


class Test_for_repository(unittest.TestCase):
    def setUp(self) -> None:
        self._functions = Repository()

    def tearDown(self) -> None:
        pass

    def test_initialize_the_game_field__returns_true(self):
        self._functions.initiate_the_game_field()
        self.assertEqual(self._functions._field_of_the_game[0][0], -1)

    def test__mark_the_selected_spot_on_the_field__returns_true(self):
        self._functions.initiate_the_game_field()
        self._functions.mark_the_selected_spot_on_the_field(0,0,True)
        self.assertEqual(self._functions._field_of_the_game[0][0], 'X')


    def test__check_if_anybody_won__valid_input_user_won(self):
        self._functions.initiate_the_game_field()
        self._functions._field_of_the_game[0][0], self._functions._field_of_the_game[1][1],\
        self._functions._field_of_the_game[2][2]='X','X','X'
        self.assertEqual(self._functions.check_if_anybody_won(), True)

