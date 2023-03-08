from texttable import Texttable


class GameUi:
    def __init__(self, service):
        self._service = service

    def start_the_game(self):
        self._service.initiate_the_field()
        is_it_users_choice = True
        print("If you would like to leave at any time, please enter x.")
        print("In order to play choose a column and a row for your move. Good luck!" + "\n")
        while self.are_we_still_playing():
            try:
                if is_it_users_choice:
                    print("The current game board: ")
                    self.print_the_actual_field()
                    user_option = input("Your turn:  ")
                    if user_option.lower() == 'x':
                        return
                    self.check_the_validity_for_user_input(user_option)
                    if not self._service.check_if_the_selected_spot_is_available(ord(user_option[0].lower())-97, user_option[1]):
                        raise ValueError("  The position you have chosen is not available.")
                    self._service.fill_the_field_for_user_choice(user_option, is_it_users_choice)
                    is_it_users_choice = False
                else:
                    computers_choice = self._service.get_computer_best_move()
                    self._service.fill_the_field_for_user_choice(computers_choice, is_it_users_choice)
                    is_it_users_choice = True
                    print("Computer choose " + str(computers_choice))
            except ValueError as ve:
                print(ve)

        self.print_the_actual_field()
        if is_it_users_choice is True:
            print(" Computer wins!")
        else:
            print("  You win!")

    def print_the_actual_field(self):
        field = self._service.display_the_field_data()
        header = []
        for letter in range(6):
            header.append(chr(65+letter))
        header.append('X')
        text = Texttable()
        text.header(header)
        position = 0
        for i in range(6):
            array = []
            for j in range(6):
                element = field[position]
                if element == -1:
                    array.append(' ')
                else:
                    array.append(element)
                position += 1
            text.add_row(array + [i])
        print(text.draw())

    @staticmethod
    def check_the_validity_for_user_input(user_input):
        if len(user_input) != 2:
            raise ValueError(" Invalid data for your turn.")
        else:
            column = user_input[0]
            row = user_input[1]
            if not str(row).isnumeric():
                raise ValueError("  The inserted data for row must be a positive integer between 0 and 5.")
            if str(column).isnumeric():
                raise ValueError("  The inserted data for column must be a letter between A and F.")
            if ord(column.lower()) < 97 or ord(column.lower()) > 102 or int(row) < 0 or int(row) > 5:
                raise ValueError("  The position chosen for your move is outside the board game!")

    def are_we_still_playing(self):
        field = self._service.display_the_field_data()
        still_playing = False
        for i in range(36):
            if field[i] == -1:
                still_playing = True
        return still_playing

    # def computer_randomly_chooses(self):
    #     choice = None
    #     list_of_choices = ['A0', 'A1', 'A2', 'A3', 'A4', 'A5', 'B0', 'B1', 'B2', 'B3', 'B4', 'B5', 'C0', 'C1', 'C2',
    #     'C3', 'C4', 'C5', 'D0', 'D1', 'D2', 'D3', 'D4', 'D5', 'E0', 'E1', 'E2', 'E3', 'E4', 'E5', 'F0', 'F1', 'F2',
    #     'F3', 'F4', 'F5']
    #     is_the_choice_valid = False
    #     while is_the_choice_valid is False:
    #         choice = random.choice(list_of_choices)
    #         if self._service.check_if_the_selected_spot_is_available(ord(choice[0].lower()) - 97, choice[1]):
    #             is_the_choice_valid = True
    #             list_of_choices.remove(choice)
    #     return choice
