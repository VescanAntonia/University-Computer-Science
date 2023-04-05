from random import random, choice

class Repository:
    def __init__(self):
        self._field_of_the_game = [[0 for i in range(3)] for j in range(3)]

    def initiate_the_game_field(self):
        """
        this function initiates the field for the game 
        :return:
        """
        for i in range(3):
            for j in range(3):
                self._field_of_the_game[i][j] = -1
        return self._field_of_the_game

    def mark_the_selected_spot_on_the_field(self, first_coordinate, second_coordinate, is_it_human_turn):
        first_coordinate = int(first_coordinate)
        second_coordinate = int(second_coordinate)
        if is_it_human_turn is True:
            symbol = 'X'
        else:
            symbol = 'O'
        if self._field_of_the_game[first_coordinate][second_coordinate] == -1:
            self._field_of_the_game[first_coordinate][second_coordinate] = str(symbol)
        return self._field_of_the_game

    def computer_chooses_the_spot(self):
        is_spot_ok = False
        choice_random = None
        while not is_spot_ok:
            choice_random = choice(list_of_spots_computer)
            if self.check_if_spot_is_empty(choice_random[0], choice_random[1]):
                is_spot_ok = True
        return choice_random

    def check_if_spot_is_empty(self, row, column):
        if self._field_of_the_game[row][column] == -1:
            return True
        else:
            return False

    def check_which_spot_is_free(self):
        for i in range(3):
            for j in range(3):
                if self._field_of_the_game[i][j] == -1:
                    return i, j

    def computer_movement_phase(self):
        row_empty, column_empty = self.check_which_spot_is_free()
        spot_to_move_i = 0
        spot_to_move_j = 0
        for i in range(3):
            for j in range(3):
                if self._field_of_the_game[i][j] == 'O':
                    if i==row_empty or j == column_empty or (row_empty==column_empty and i==j) or (row_empty+column_empty+1==3 and i+j+1==3):
                        spot_to_move_i = int(i)
                        spot_to_move_j = int(j)
        self._field_of_the_game[row_empty][column_empty] = 'O'
        self._field_of_the_game[spot_to_move_i][spot_to_move_j] = -1
        return self._field_of_the_game


    def user_movement_phase(self, user_row, user_column):
        user_row = int(user_row)
        user_column = int(user_column)
        row, column = self.check_which_spot_is_free()
        if self._field_of_the_game[user_row][user_column] != 'X':
            raise ValueError("The spot is not yours. ")
        self._field_of_the_game[row][column] = 'X'
        self._field_of_the_game[user_row][user_column] = -1
        return self._field_of_the_game


    def check_if_anybody_won(self):
        somebody_won = False
        symbol_won = None
        for i in range(3):
            if self._field_of_the_game[i][0]==self._field_of_the_game[i][1]==self._field_of_the_game[i][2]:
                somebody_won = True
                symbol_won = self._field_of_the_game[i][0]
        for j in range(3):
            if self._field_of_the_game[0][j] == self._field_of_the_game[1][j] == self._field_of_the_game[2][j]:
                somebody_won = True
                symbol_won = self._field_of_the_game[0][j]
        if self._field_of_the_game[0][0] == self._field_of_the_game[1][1] == self._field_of_the_game[2][2]:
            somebody_won= True
            symbol_won = self._field_of_the_game[0][0]
        if self._field_of_the_game[0][2] == self._field_of_the_game[1][1] == self._field_of_the_game[2][0]:
            somebody_won =True
            symbol_won = self._field_of_the_game[0][2]
        if somebody_won is True and symbol_won!=-1:
            return True
        else:
            return False

    def get_current_field(self):
        field_to_display = []
        for i in range(3):
            for j in range(3):
                field_to_display.append(self._field_of_the_game[i][j])
        return field_to_display

    def check_who_won(self):
        somebody_won = False
        symbol_won = None
        given_symbol = None
        for i in range(3):
            if self._field_of_the_game[i][0] == self._field_of_the_game[i][1] == self._field_of_the_game[i][2]:
                somebody_won = True
                symbol_won = self._field_of_the_game[i][0]
        for j in range(3):
            if self._field_of_the_game[0][j] == self._field_of_the_game[1][j] == self._field_of_the_game[2][j]:
                somebody_won = True
                symbol_won = self._field_of_the_game[0][j]
        if self._field_of_the_game[0][0] == self._field_of_the_game[1][1] == self._field_of_the_game[2][2]:
            somebody_won = True
            symbol_won = self._field_of_the_game[0][0]
        if self._field_of_the_game[0][2] == self._field_of_the_game[1][1] == self._field_of_the_game[2][0]:
            somebody_won = True
            symbol_won = self._field_of_the_game[0][2]
        if somebody_won is True and symbol_won != -1:
            given_symbol = symbol_won
        if given_symbol == 'X':
            return True
        else:
            return False

    def we_are_still_playing(self):
        empty_spots = 0
        for i in range(3):
            for j in range(3):
                if self._field_of_the_game[i][j] == -1:
                    empty_spots += 1
        if empty_spots > 1:
            return True
        else:
            return False


list_of_spots_computer = [(0, 1), (0, 0), (0, 2), (1, 0), (1, 1), (1, 2), (2, 0), (2, 1), (2, 2)]
