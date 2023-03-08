class Repository:
    def __init__(self):
        self._field = [[0 for i in range(6)] for j in range(6)]

    def initiate_the_field_for_game(self):
        """
        This function initiates the field of the game with the initial value -1 which means it is empty
        :return: the field with the initial values
        """
        for i in range(6):
            for j in range(6):
                self._field[i][j] = -1

    def get_field_to_display(self):
        """
        This function gets the data for the game board in order to print it and inform the user about the stage of the
        game
        :return: a list containing the values of the field
        """
        field_to_be_displayed = []
        for i in range(6):
            for j in range(6):
                field_to_be_displayed.append(self._field[i][j])
        return field_to_be_displayed

    def check_if_the_given_spot_in_field_is_empty(self, column, row):
        """
        :param column: column of the element in the field
        :param row: the row of the element in the field
        :return: true if the spot in the field is available and a move can be made there or false otherwise
        """
        column = int(column)
        row = int(row)
        if self._field[row][column] == -1:
            return True
        return False

    def pick_the_position_and_mark_it_based_on_user_choice(self, user_choice, users_turn):
        """
        This function marks the position of the current move
        :param user_choice: the choice that was made regarding the move
        :param users_turn: has the value true if it is the user that chose the move or false otherwise
        :return: the new field with the marked spots
        """
        column = int(ord(user_choice[0].lower())-97)
        row = int(user_choice[1])
        if users_turn is True:
            symbol_to_be_used = 'o'
        else:
            symbol_to_be_used = 'x'
        if self._field[row][column] == -1:
            self._field[row][column] = str(symbol_to_be_used)
            if self._field[row-1][column] == -1 and row != 0:
                self._field[row-1][column] = '/'
            if self._field[row][column-1] == -1 and column != 0:
                self._field[row][column-1] = '/'
            if row != 5 and self._field[row + 1][column] == -1:
                self._field[row + 1][column] = '/'
            if column != 5 and self._field[row][column + 1] == -1:
                self._field[row][column+1] = '/'
            # if column !=5 and self._field[row+1][column+1] == -1:
            #     self._field[row+1][column+1] = '/'
            # if self._field[row-1][column-1] == -1:
            #     self._field[row-1][column-1] = '/'
            # if self._field[row-1][column+1] ==-1:
            #     self._field[row-1][column+1] ='/'
            # if self._field[row+1][column-1] == -1:
            #     self._field[row+1][column-1] = '/'


    def check_which_move_is_better_computer(self):
        """
        This function's purpose is to make the game competitive checking which is the move that would mark more spots in order to make the computer win
        :return:the move the computer needs to make
        """
        maximum = -1
        move_to_be_made = list_of_choices[0]
        for current_possible_move in list_of_choices:
            if len(list_of_choices) == 1:
                move_to_be_made = list_of_choices[0]
            elif self.check_if_the_given_spot_in_field_is_empty(ord(current_possible_move[0].lower()) - 97, current_possible_move[1]):
                current_spaces = self.find_how_many_spaces_it_covers(current_possible_move)
                if current_spaces >= maximum:
                    maximum = current_spaces
                    move_to_be_made = current_possible_move
        return move_to_be_made

    def find_how_many_spaces_it_covers(self, current_option_move):
        """
        This function finds the number of spots a given move would mark
        :param current_option_move: the current option which is being analyzed
        :return: the number of spots that this move would mark
        """
        boxes_to_be_filled = 0
        column = int(ord(current_option_move[0].lower())-97)
        row = int(current_option_move[1])
        if self._field[row-1][column] == -1 and row != 0:
            boxes_to_be_filled += 1
        if self._field[row][column-1] == -1 and column != 0:
            boxes_to_be_filled += 1
        if row != 5 and self._field[row + 1][column] == -1:
            boxes_to_be_filled += 1
        if column != 5 and self._field[row][column + 1] == -1:
            boxes_to_be_filled += 1
        return boxes_to_be_filled


list_of_choices = ['A0', 'A1', 'A2', 'A3', 'A4', 'A5', 'B0', 'B1', 'B2', 'B3', 'B4', 'B5', 'C0', 'C1', 'C2',
                           'C3', 'C4', 'C5', 'D0', 'D1', 'D2', 'D3', 'D4', 'D5', 'E0', 'E1', 'E2', 'E3', 'E4', 'E5',
                           'F0', 'F1', 'F2', 'F3', 'F4', 'F5']



