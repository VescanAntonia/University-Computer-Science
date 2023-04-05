class Service:
    def __init__(self, repository):
        self._repository = repository

    def initiate_the_list(self):
        return self._repository.initialize_the_list_of_sentences()

    def get_the_list(self):
        return self._repository.get_the_list_elements()

    def check_the_letter(self,given_sentence, letter):
        return self._repository.check_if_letter_in_sentence(given_sentence,letter)

    def initialize_list_of_words(self,sentence):
        return self._repository.initialize_the_list_for_words_to_be_printed(sentence)

    def update_hungman(self, given_hungman):
        return self._repository.update_hungman_word(given_hungman)

    def are_we_still_playing(self, sentence, letters_List):
        return self._repository.check_we_still_playing(sentence, letters_List)

    def add_sentence(self, given_sentence):
        return self._repository.add_sentence_to_list(given_sentence)