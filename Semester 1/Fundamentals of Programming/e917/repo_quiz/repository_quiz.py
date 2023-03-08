from domain_quiz.domain_quiz import DomainQuiz


class RepositoryQuiz:
    def __init__(self, file_path):
        self._list_of_questions = []
        self._file_path = file_path

    def read_from_file(self):
        """
        this function read from the given file the given questions
        :return: the list of the questions
        """
        with open(self._file_path, 'r') as read_file:
            lines = read_file.readlines()
            for line in lines:
                line = line.strip()
                if len(line):
                    quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty = self.split_the_given_input(line)
                    quiz_id = int(quiz_id)
                    self._list_of_questions.append(DomainQuiz(quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty))

    def append_to_file(self,element):
        """
        this function appends to file the new added question
        :param element: the new element
        :return: appends to file
        """
        with open(self._file_path, 'a') as write_file:
            el_to_write = element.to_file()
            write_file.write(str(el_to_write))

    def initialize_the_data(self):
        """
        this function initializes the list from the file
        :return:
        """
        self.read_from_file()
        return self._list_of_questions

    def add_question_to_list(self, given_input):
        """
        This function adds a question to the list of questions
        :param given_input: the new question
        :return: adds the question to the list
        """
        quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty = self.split_the_given_input(given_input)
        quiz_id = quiz_id.split()[1]
        self.check_if_input_is_correct(quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty)
        self._list_of_questions.append(DomainQuiz(quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty))
        self.append_to_file(DomainQuiz(quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty))

    def check_if_input_is_correct(self,quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty):
        """
        checks if the given input is valid
        :param quiz_id: id of question
        :param text: question
        :param choice_a: first choice
        :param choice_b: second choice
        :param choice_c: third choice
        :param correct_choice: the correct choice
        :param difficulty: the difficulty
        :return: checks if the input is valid
        """
        if int(quiz_id)< 0 and not str(quiz_id).isnumeric():
            raise ValueError(" The id is not valid")
        if str(text).isnumeric():
            raise ValueError(" The question is not valid.")

    def split_the_given_input(self, given_input):
        """
        this function splits the parameters to be added to the list
        :param given_input: the given input from the user
        :return: returns the splited parameters
        """

        given_input = given_input.split(';')
        if len(given_input)!=7:
            raise ValueError(" Not all the components of the question were added!")
        input_id = given_input[0]
        input_text = given_input[1]
        input_a = given_input[2]
        input_b = given_input[3]
        input_c = given_input[4]
        input_correct = given_input[5]
        input_difficulty = given_input[6]
        return input_id, input_text, input_a, input_b, input_c,input_correct, input_difficulty

    def get_list_of_el(self):
        """
        this function returns the list of elements
        """
        list_to_print = ''
        for el in self._list_of_questions:
            print(el.print_format())
        return list_to_print

    def start_a_quiz(self, the_parameters):
        """
        this function starts a quiz based on the given text file
        :param the_parameters: the given parameters for starting the game which contain the file from which to download the questions
        :return: the list of the functions from the game
        """
        list_of_current_quiz = []
        first_parameter, second_parameter =self.split_parameters_for_starting_a_quiz(the_parameters)
        if second_parameter not in possible_quizes:
            raise ValueError("The given file does not exist! Try another one.")
        with open(str(second_parameter), 'r') as quiz_in_progress:
            lines = quiz_in_progress.readlines()
            for line in lines:
                line = line.strip()
                if len(line):
                    quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty = self.split_the_given_input(
                        line)
                    quiz_id = int(quiz_id)
                    list_of_current_quiz.append(
                        DomainQuiz(quiz_id, text, choice_a, choice_b, choice_c, correct_choice, difficulty))
        return list_of_current_quiz

    def are_we_playing(self,list,index):
        """
        this function checks if we are still playing
        :param list: list of the questions
        :param index: the currents question
        :return:
        """
        return index!=len(list)

    def keep_playing_the_game(self, list_el, index):
        """
        check if we are still playing
        :param list_el: list of questions
        :param index: the nr of question
        :return:
        """
        question_to_print = ''
        for element in list_el:
            if int(element.get_quiz_id()) == index:
                question_to_print += str(element.get_quiz_id()) +' '+ str(element.get_text())+' '+str(element.get_choice_a())+' '+ str(element.get_choice_b())+' '+str(element.get_choice_c())
                #question_to_print= element.print_format()
        return question_to_print

    # def create_a_new_quiz(self, given_user_input_for_quiz):
    #     first_word,second_word,third_word,fourth_word = self.split_parameters_for_creating_the_quiz(given_user_input_for_quiz)
    #
    def split_parameters_for_starting_a_quiz(self, given_parameters_to_split):
        """
        this function returns the splited parameters for the started quiz
        :param given_parameters_to_split: given user input
        :return: the splited input
        """
        given_parameters_to_split = given_parameters_to_split.split(' ')
        if len(given_parameters_to_split) != 2:
            raise ValueError("Invalid command for starting a quiz. Try again.")
        return given_parameters_to_split[0], given_parameters_to_split[1]

    def split_parameters_for_creating_the_quiz(self, given_input_for_quiz):
        """
        this function splits the parameters for creating a quiz
        :param given_input_for_quiz: given quiz requests
        :return: the splited parameters for the quiz to be created
        """
        given_input_for_quiz = given_input_for_quiz.split(' ')
        if len(given_input_for_quiz)!=4:
            raise ValueError("Invalid command for creating a quiz. Try again.")
        return given_input_for_quiz[0], given_input_for_quiz[1], given_input_for_quiz[2], given_input_for_quiz[3]

    def check_if_answer_is_ok(self, answer,index, list_for_el):
        """
        this checks if the answer is correct
        :param answer: given answer
        :param index: current question
        :param list_for_el: list of the questions
        :return: true if the answer is ok, false otherwise
        """
        for elements in list_for_el:
            if (elements.get_quiz_id() == index) and elements.get_correct_choice() == answer:
                return True
        return False


possible_quizes = ['question.txt']