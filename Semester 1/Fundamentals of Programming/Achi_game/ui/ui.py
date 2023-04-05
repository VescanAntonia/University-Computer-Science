from texttable import Texttable


class GameUi:
    def __init__(self, service):
        self._service = service

    @staticmethod
    def show_menu():
        print("Enter your option: ")
        print(" If you would like to leave at any time enter x.")

    def start(self):
        self._service.get_the_initial_field()
        self.show_menu()
        is_it_humans_turn = True
        while self._service.are_we_still_playing() and not self._service.check_if_anyone_won():
            try:
                if is_it_humans_turn:
                    self.print_the_actual_field()
                    user_input_first_coordinate = input(" Enter your option for the row placement:  ")
                    if str(user_input_first_coordinate).lower() == 'x':
                        return
                    else:
                        user_input_first_coordinate = int(user_input_first_coordinate)
                    user_input_second_coordinate = int(input("Enter your second coordinate for the column placement: "))
                    self.check_user_input(user_input_first_coordinate,user_input_second_coordinate)
                    self._service.mark_the_selected_spots(user_input_first_coordinate,user_input_second_coordinate,is_it_humans_turn)
                    is_it_humans_turn = False
                else:
                    picked_position = self._service.computer_chooses()
                    self._service.mark_the_selected_spots(picked_position[0], picked_position[1], is_it_humans_turn)
                    is_it_humans_turn = True
            except ValueError as ve:
                print(str(ve))
        self.print_the_actual_field()
        if self._service.check_if_anyone_won():
            if self._service.did_user_won():
                print( "User won in placement phase.")
            else:
                print("Computer won in placement phase.")
        else:
            momevent_phase = True
            while momevent_phase and not self._service.check_if_anyone_won():
                try:

                    if is_it_humans_turn:
                        self.print_the_actual_field()
                        user_input_first_coordinate = input(" Enter the row of the piece you want to move: ")
                        if str(user_input_first_coordinate).lower() == 'x':
                            return
                        else:
                            user_input_first_coordinate = int(user_input_first_coordinate)
                            user_input_second_coordinate = int(input("Enter the column of the piece you want to move: "))
                            if user_input_first_coordinate>2 or user_input_second_coordinate>2:
                                raise ValueError(" Invalid move, outside the board. ")
                            self._service.user_moves(user_input_first_coordinate,user_input_second_coordinate)
                            # self._service.mark_the_selected_spots(user_input_first_coordinate, user_input_second_coordinate,
                            #                                   is_it_humans_turn)
                            is_it_humans_turn = False
                    else:
                        self._service.computer_moves()
                        # picked_position = self._service.computer_chooses()
                        # self._service.mark_the_selected_spots(picked_position[0], picked_position[1], is_it_humans_turn)
                        is_it_humans_turn = True
                except ValueError as ve:
                    print(str(ve))
            self.print_the_actual_field()
            if self._service.check_if_anyone_won():
                if self._service.did_user_won():
                    print("User won in movement phase.")
                else:
                    print("Computer won in movement phase.")

    def print_the_actual_field(self):
        print("The current game board: ")
        field = self._service.get_the_field_current()
        text = Texttable()
        position = 0
        for i in range(3):
            array = []
            for j in range(3):
                element = field[position]
                if element == -1:
                    array.append(' ')
                else:
                    array.append(element)
                position += 1
            text.add_row(array)
        print(text.draw())

    def check_user_input(self, given_row, given_column):
        if given_row>2 or given_column>2:
            raise ValueError("Picked spot is outside the game board! Try again!")
        if not self._service.check_available_spot(given_row,given_column):
            raise ValueError("The spot is not available!Try again!")

