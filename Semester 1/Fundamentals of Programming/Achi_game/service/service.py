class Service:
    def __init__(self, repository):
        self._repository = repository

    def get_the_initial_field(self):
        return self._repository.initiate_the_game_field()

    def get_the_field_current(self):
        return self._repository.get_current_field()

    def mark_the_selected_spots(self, row,column,user_turn):
        return self._repository.mark_the_selected_spot_on_the_field(row,column,user_turn)

    def computer_chooses(self):
        return self._repository.computer_chooses_the_spot()

    def are_we_still_playing(self):
        return self._repository.we_are_still_playing()

    def check_available_spot(self, row, column):
        return self._repository.check_if_spot_is_empty(row,column)

    def check_if_anyone_won(self):
        return self._repository.check_if_anybody_won()

    def did_user_won(self):
        return self._repository.check_who_won()

    def user_moves(self, inserted_row, inserted_column):
        return self._repository.user_movement_phase(inserted_row,inserted_column)

    def computer_moves(self):
        return self._repository.computer_movement_phase()
