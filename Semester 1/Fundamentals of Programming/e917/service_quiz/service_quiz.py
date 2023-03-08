class ServiceQuiz:
    def __init__(self, repository):
        self._repository = repository

    def add_new_queston_to_List(self,user_input):
        return self._repository.add_question_to_list(user_input)

    def initialize_the_list(self):
        return self._repository.initialize_the_data()

    def get_list(self):
        return self._repository.get_list_of_el()

    def create_a_given_quiz(self, user_given_input_for_quiz):
        return self._repository.create_a_new_quiz(user_given_input_for_quiz)

    def start_a_given_quiz(self, given_quiz):
        return self._repository.start_a_quiz(given_quiz)

    def are_we_Playing(self, list_elements,index):
        return self._repository.are_we_playing(list_elements, index)

    def keep_playing(self, list, index_current):
        return self._repository.keep_playing_the_game(list,index_current)

    def check_if_answer_is_ok(self, answer_given, index, list_for_elements):
        return self._repository.check_if_answer_is_ok(answer_given,index, list_for_elements)

