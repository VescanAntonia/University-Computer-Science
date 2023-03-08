class Service:
    def __init__(self, repository):
        self._repository = repository

    def initiate_the_field(self):
        return self._repository.initiate_the_field_for_game()

    def display_the_field_data(self):
        return self._repository.get_field_to_display()

    def check_if_the_selected_spot_is_available(self, given_column, given_row):
        return self._repository.check_if_the_given_spot_in_field_is_empty(given_column, given_row)

    def fill_the_field_for_user_choice(self, given_user_choice, users_turn):
        return self._repository. pick_the_position_and_mark_it_based_on_user_choice(given_user_choice, users_turn)

    def get_computer_best_move(self):
        return self._repository.check_which_move_is_better_computer()
