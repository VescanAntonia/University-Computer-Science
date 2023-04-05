from random import choice


class Repository:
    def __init__(self, file_path):
        self._list_of_sentences = []
        self._file_path = file_path

    def read_from_file(self):
        with open(self._file_path, 'r') as reading_from_file:
            self._list_of_sentences.clear()
            lines = reading_from_file.readlines()
            for line in lines:
                line = line.strip()
                if len(line):
                    self._list_of_sentences.append(line)

    def write_all_to_files(self):
        with open(self._file_path, 'w') as writing_to_file:
            for sentence in self._list_of_sentences:
                writing_to_file.write(sentence + '\n')

    def add_sentence_to_list(self, sentence):
        index = 0
        for i in range(len(sentence)):
            if sentence[i]!=' ':
                index+=1
            else:
                if index<3:
                    raise ValueError("not all words have 3 letters! ")
                else:
                    index = 0
        if sentence in self._list_of_sentences:
            raise ValueError("sentence is already in the list")
        if index <3:
            raise ValueError("not all words have 3 letters! ")
        self._list_of_sentences.append(sentence)
        self.write_all_to_files()



    def initialize_the_list_of_sentences(self):
        self.read_from_file()
        return self.computer_chooses_sentence(self._list_of_sentences)

    def check_we_still_playing(self, given_sentence, list_of_letters):
        decision = False
        for i in range(len(given_sentence)):
            if not given_sentence[i].lower() in list_of_letters and given_sentence[i]!=' ':
                decision = True
        return decision

    def update_hungman_word(self, word):
        if len(word)==0:
            return 'h'
        if len(word) == 1:
            return 'a'
        if len(word)==2:
            return 'n'
        if len(word)==3:
            return 'g'
        if len(word)==4:
            return 'm'
        if len(word)==5:
            return 'a'
        if len(word)==6:
            return 'n'

    def check_if_letter_in_sentence(self, sentence, given_letter):
        return given_letter in sentence.lower()
        # for i in range(len(sentence)):
        #     if (sentence[i]).lower() == given_letter:
        #         return True
        #     else:
        #         return False

    def initialize_the_list_for_words_to_be_printed(self, given_sentence):
        list_to_print = []
        list_to_print.append(given_sentence[0].lower())
        list_to_print.append(given_sentence[len(given_sentence)-1].lower())
        for i in range(len(given_sentence)):
            if i != 0 and given_sentence[i-1] ==' ' or i != len(given_sentence)-1 and given_sentence[i+1]==' ' :
                list_to_print.append(given_sentence[i])
        return list_to_print

    def computer_chooses_sentence(self, list_sentences):
        random_choice = choice(list_sentences)
        return random_choice

    def read_function(self):
        pass

    def write_function(self):
        pass

    def get_the_list_elements(self):
        return self._list_of_sentences