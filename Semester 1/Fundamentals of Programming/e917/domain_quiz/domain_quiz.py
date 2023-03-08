class DomainQuiz:
    def __init__(self, quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty):
        self._quiz_id = quiz_id
        self._text = text
        self._choice_a = choice_a
        self._choice_b = choice_b
        self._choice_c = choice_c
        self._correct_choice_choice = correct_choice
        self._difficulty = difficulty

    def get_quiz_id(self):
        return self._quiz_id

    def get_text(self):
        return self._text

    def get_choice_a(self):
        return self._choice_a

    def get_choice_b(self):
        return self._choice_b

    def get_choice_c(self):
        return self._choice_c

    def get_correct_choice(self):
        return self._correct_choice_choice

    def print_format(self):
        return str(
            str(self._quiz_id) + ' ' + str(self._text) + ' ' + str(self._choice_a) +' '+ str(self._choice_b) + ' ' + str(
                self._choice_c) + ' ' + str(self._correct_choice_choice) + ' ' + str(self._difficulty))

    def from_file(self, given_input):
        given_input = given_input.split(';')
        input_id = given_input[0]
        input_text = given_input[1]
        input_a = given_input[2]
        input_b = given_input[3]
        input_c = given_input[4]
        input_correct = given_input[5]
        input_difficulty = given_input[6]
        return input_id, input_text, input_a, input_b, input_c, input_correct, input_difficulty

    def to_file(self):
        return '\n'+ str(str(self._quiz_id) + ';' + str(self._text) + ';' + str(self._choice_a) + str(self._choice_b) + ';' + str(
                self._choice_c) + ';' + str(self._correct_choice_choice) + ';' + str(self._difficulty))
