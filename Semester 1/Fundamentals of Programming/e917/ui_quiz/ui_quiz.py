class GameUi:
    def __init__(self, service):
        self._service = service

    @staticmethod
    def show_menu():
        print("Welcome to quiz masters! \n If you woul like to exit, please type exit. ")
        print("You can: Add a new question. \n         Create a new quiz. \n         Start a quiz.(possible quizes: question.txt)")

    def start(self):
        self._service.initialize_the_list()
        self.show_menu()
        while True:
            try:
                user_input = input("Enter you option: ")
                copy_of_input = user_input
                if len(user_input)< 1:
                    raise ValueError("No option has been added!")
                if self.split_parameters(user_input).lower() == 'add':
                    self._service.add_new_queston_to_List(user_input)
                elif self.split_parameters(user_input).lower() == 'exit':
                    return
                elif self.split_parameters(user_input). lower()== 'print':
                    list_to_print = self._service.get_list()
                    for el in list_to_print:
                        print(str(el))
                elif self.split_parameters(user_input).lower() == 'create':
                    pass
                    #self._service.create_a_given_quiz(user_input)
                elif self.split_parameters(user_input).lower() == 'start':
                    list_of_questions = self._service.start_a_given_quiz(user_input)
                    are_we_still_playing = True
                    index = 1
                    while are_we_still_playing:
                        try:
                            are_we_still_playing = self._service.are_we_Playing(list_of_questions,index)
                            current_question = self._service.keep_playing(list_of_questions,index)
                            print(current_question)
                            user_choice = input("enter your choice: ")
                            is_the_answer_ok = self._service.check_if_answer_is_ok(user_choice, index, list_of_questions)

                            index +=1
                            print(is_the_answer_ok)
                        except ValueError as ve:
                            print(str(ve))
            except ValueError as ve:
                print(str(ve))

    def split_parameters(self, given_option):
        given_option = given_option.split()
        return given_option[0]
