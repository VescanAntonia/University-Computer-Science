import unittest
from repo_quiz.repository_quiz import RepositoryQuiz


class Test_for_repo(unittest.TestCase):
    def setUp(self) -> None:
        self._function = RepositoryQuiz("question.txt")

    def tearDown(self) -> None:
        pass

    def test__split_the_given_input__valid_input__returns_the_splited_list(self):
        splited_list = self._function.split_the_given_input("5;a;b;c;d;e;f")
        self.assertEqual(splited_list[0], '5')

    def test__split_the_given_input__valid_input__returns_the_splited_List(self):
        splited_list = self._function.split_the_given_input("6;question;c;e;f;b;dif")
        self.assertEqual(splited_list[0], '6')

    def test__split_parameters_for_starting_a_quiz__returns_splited_param(self):
        splited_params = self._function.split_parameters_for_starting_a_quiz("5 n")
        self.assertEqual(splited_params[0],'5')

    def test__are_we_playing__returns_true(self):
        self.assertEqual(self._function.are_we_playing(self._function._list_of_questions, 1), True)

    def test__are_we_playing__returns_false(self):
        self.assertEqual(self._function.are_we_playing([4,5], 2), False)

    def test__check_if_answer_is_ok__returns_false(self):
        self.assertEqual(self._function.check_if_answer_is_ok('7','1', self._function._list_of_questions), False)

