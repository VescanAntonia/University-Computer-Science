from texttable import Texttable


class GameUi:
    def __init__(self, service):
        self._service = service

    @staticmethod
    def show_menu():
        print(" Welcome to the game, if you would like to leave at any time type exit. \n Good luck!")
        print(" Would you like to: add a sentence \n                    play a game?")

    def start(self):
        self.show_menu()
        current_sentence = self._service.initiate_the_list()
        current_found_letters = self._service.initialize_list_of_words(current_sentence)
        hangman_word = ''
        are_we_still_playing = True
        while True:
            try:
                user_choice = input("your option:  ")
                if user_choice.lower() == 'add':
                    sentence = input("insert the sentence:  ")
                    self._service.add_sentence(sentence)
                elif user_choice.lower() == 'exit':
                    return
                elif user_choice.lower() == 'play':
                    while len(hangman_word) != 7 and are_we_still_playing:
                        try:
                            self.print_the_actual_sentence(current_sentence, current_found_letters, hangman_word)
                            user_input = input(" Enter your option: ")
                            if str(user_input).lower() == 'exit':
                                return
                            is_the_letter_in_word = self._service.check_the_letter(current_sentence, user_input)
                            if is_the_letter_in_word:
                                current_found_letters.append(user_input)
                            else:
                                hangman_word += str(self._service.update_hungman(hangman_word))
                            are_we_still_playing = self._service.are_we_still_playing(current_sentence, current_found_letters)
                        except ValueError as ve:
                            print(str(ve))
                    self.print_the_actual_sentence(current_sentence, current_found_letters, hangman_word)
                    if len(hangman_word) == 7:
                        print("You lost!")
                    else:
                        print("You won!")
                    return
            except ValueError as ve:
                print(str(ve))

    def print_the_actual_sentence(self, sentence_given, guessed_letters, hangman):
        array = ''
        for i in range(len(sentence_given)):
            if sentence_given[i].lower() in guessed_letters:
                array += sentence_given[i]
            elif sentence_given[i] == ' ':
                array += '   '
            else:
                array += ' _ '
        array += '  '
        array += hangman
        print(array)

    # def print_the_field(self):
    #     field = self._service.get_the_field()
    #     header = []
    #     for i in range(3):
    #         header.append(chr(i+65))
    #     header.append('X')
    #     text = Texttable()
    #     text.header(header)
    #     for i in range(3):
    #         array = []
    #         for j in range(3):
    #             element = field[i][j]
    #             if element == -1:
    #                 array.append(' ')
    #             else:
    #                 array.append(element)
    #         array.append(i)
    #         text.add_row(array)
    #     print(text.draw())