"""
  Write non-UI functions below
"""


from datetime import date


def init_list_of_expenses():
    """
    Create a few test expenses
    :return: The list of the created expenses
    """
    return [(12, 50, 'transport'), (5, 100, 'food'), (18, 70, 'housekeeping'), (20, 70, 'food'), (13, 50, 'internet'),
            (19, 200, 'clothing'), (11, 40, 'transport'), (30, 150, 'food'), (3, 40, 'internet'),
            (27, 80, 'healthcare')]


def get_day_of_expense(expense):
    return expense[0]    # returns the day in which the expense was made


def get_amount_of_money_expense(expense):
    return expense[1]    # returns the amount of money


def get_category_of_expense(expense):
    return expense[2]    # returns the category of the expense


def split_command(user_command):
    """
    Split the user's command into the command word and a parameters string
    ex:
         add 25 100 food  -> ('add', '25 100 food')
         remove 2 to 9    -> ('remove', '2 to 9')
         exit             -> ('exit', None)
    :param user_command: Command input by the user
    :return: A tuple of (<command word>, <command params>)
    """
    user_command = user_command.strip()
    command_words = user_command.split(maxsplit=1)
    command_word = command_words[0].lower() if len(command_words) > 0 else None
    command_parameter = command_words[1].lower() if len(command_words) == 2 else None

    return command_word, command_parameter


def split_the_parameters(command_parameters):
    """
    :param command_parameters: a string that contains the parameters regarding the expense
    :return: the list containing the parameters
    """
    command_parameters = command_parameters.strip(' ')
    list_of_parameters = command_parameters.split(maxsplit=1)
    return list_of_parameters


def get_day_of_current_day(current_date):
    """
    :param current_date: the date when the expense is introduced
    :return: the day from the current date
    """
    present_date = str(current_date)
    present_date = present_date.split('-')
    return present_date[2]


def display_expenses_for_given_money(list_expenses, list_parameters):
    """
    :param list_expenses: the list with the expenses
    :param list_parameters: the list with the parameters
    :return: splits the parameters
    """
    parameters = [list_parameters[0]]
    list_parameters[1] = list_parameters[1].split()
    parameters.append(list_parameters[1][0])
    parameters.append(list_parameters[1][1])
    display_expenses_for_given_money_ui(list_expenses, parameters)


def display_the_list_of_expenses(list_of_expenses, command_parameters):
    if command_parameters is None:
        display_all_the_expenses(list_of_expenses)
    else:
        parameters = split_the_parameters(command_parameters)     # calls another function depending the number of
        if len(parameters) == 1:                                        # parameters
            display_all_for_given_category(list_of_expenses, command_parameters)
        elif len(parameters) == 2:
            display_expenses_for_given_money(list_of_expenses, parameters)


def remove_the_user_choices(list_of_expenses, parameters_choice):
    if parameters_choice is None:                      # exception if there is not specified what needs to be removed
        raise ValueError('A property is expected.')
    parameters_choice = parameters_choice.split(' ')
    if len(parameters_choice) == 1 and parameters_choice[0].isalpha():
        remove_expenses_from_requested_category(list_of_expenses, parameters_choice)   # it calls different functions
    elif len(parameters_choice) == 1 and 31 > int(parameters_choice[0]) > 0:        # depending on the parameters
        remove_expenses_from_requested_day(list_of_expenses, parameters_choice)
    elif len(parameters_choice) == 3:
        remove_expenses_for_a_requested_interval(list_of_expenses, parameters_choice)
    else:
        raise ValueError("The inserted property does not match the required criteria.")


"""
  Write the command-driven UI below
"""


def insert_expense(list_of_expenses, command_parameters):
    """
    :param list_of_expenses: the list of the expenses
    :param command_parameters: the parameters representing the given properties
    :return: adds to the list the new expense or a message if it is not possible
    """
    if command_parameters is None:
        raise ValueError('Day of the expense, amount of money and the category of the expense must be added. ')
    command_parameters = command_parameters.split(' ')
    if len(command_parameters) < 3:
        raise ValueError("Day of the expense, amount of money and the category of the expense must be added. ")
    else:
        command_parameters = command_parameters
        expense = str(command_parameters[0]), command_parameters[1], str(command_parameters[2])
        list_of_expenses.append(expense)
    print("Expense added successfully!")


def display_expenses_for_given_money_ui(list_expenses, parameters):
    """
    :param list_expenses: the list of the expenses
    :param parameters: representing the category of the new expense and the property it has
    :return: displays on the console the expenses which meet the conditions or a specific message if there are not
            expenses with the given property
    """
    exists = False
    for expense in list_expenses:
        if parameters[0] == get_category_of_expense(expense):
            if parameters[1] == "=" and str(get_amount_of_money_expense(expense)) == str(parameters[2]):
                print('Day: ' + str(get_day_of_expense(expense)) + ' Amount of money: ' +
                      str(get_amount_of_money_expense(expense)) + ' Category: ' + get_category_of_expense(expense))
                exists = True
            elif parameters[1] == '>' and get_amount_of_money_expense(expense) > int(parameters[2]):
                print('Day: ' + str(get_day_of_expense(expense)) + ' Amount of money: ' +
                      str(get_amount_of_money_expense(expense)) + ' Category: ' + get_category_of_expense(expense))
                exists = True
            elif parameters[1] == '<' and get_amount_of_money_expense(expense) < int(parameters[2]):
                print('Day: ' + str(get_day_of_expense(expense)) + ' Amount of money: ' +
                      str(get_amount_of_money_expense(expense)) + ' Category: ' + get_category_of_expense(expense))
                exists = True
    if not exists:
        print('There are not expenses that meet the given property.')


def display_all_the_expenses(expenses):
    """
    Displays on the console all the expenses
    :param expenses: the list of the expenses
    :return: all the expenses
    """
    i = 1
    for expense in expenses:
        print(str(i) + '.Day: ' + str(get_day_of_expense(expense))+' Amount of money: ' +
              str(get_amount_of_money_expense(expense)) + ' Category: ' + get_category_of_expense(expense))
        i = i+1


def remove_expenses_from_requested_day(expenses_list, parameters):
    for expense in expenses_list:
        if int(expense[0]) == int(parameters[0]):       # removes the expenses for a given day
            expenses_list.remove(expense)
    print("Expense removed successfully!")


def remove_expenses_from_requested_category(list_of_expenses, parameters_choice):
    for element in list_of_expenses:
        if element[2] == parameters_choice[0]:        # removes the expenses for a given category
            list_of_expenses.remove(element)
    print("Expense removed successfully!")


def remove_expenses_for_a_requested_interval(list_of_expenses, parameters_choice):
    for element in list_of_expenses:
        if int(parameters_choice[0]) <= int(element[0]) <= int(parameters_choice[2]):
            list_of_expenses.remove(element)                     # removes the expenses for a given interval of days
    print("Expense removed successfully!")


def display_all_for_given_category(list_of_expenses, category):
    for element in list_of_expenses:
        if get_category_of_expense(element) == category:           # lists all the expenses for a given category
            print('.Day: ' + str(get_day_of_expense(element))+' Amount of money: ' +
                  str(get_amount_of_money_expense(element)) + ' Category: ' + get_category_of_expense(element))


def add_new_expense(list_of_expenses, command_parameters):
    if command_parameters is None:
        raise ValueError("Amount of money and category requested")
    else:                                                        # displays a message if the introduced command is not
        command_parameters = command_parameters.split()                  # right or adds a new expense to the list

    if len(command_parameters) == 2:
        expense = str(get_day_of_current_day(date.today())), str(command_parameters[0]), str(command_parameters[1])
        list_of_expenses.append(expense)
        print("Expense added successfully!")
    else:
        raise ValueError("Both amount of money and category of the expense must be added. ")


def print_menu():
    print("\tAvailable options: ")
    print("\t  Add a new expense")
    print("\t  Remove expenses")
    print("\t  Display expenses with different properties")
    print("\t  Exit")


def start_command():
    """
    Start command-based UI
    <command word> <command parameters>

    """
    list_of_expenses = init_list_of_expenses()
    print_menu()

    while True:
        command = input("Enter your command: ")
        command_word, command_parameters = split_command(command)

        try:
            if command_word == 'list':
                display_the_list_of_expenses(list_of_expenses, command_parameters)
            elif command_word == 'remove':
                remove_the_user_choices(list_of_expenses, command_parameters)
            elif command_word == 'add':
                add_new_expense(list_of_expenses, command_parameters)
            elif command_word == 'insert':
                insert_expense(list_of_expenses, command_parameters)
                # Might quit with ValueError
            elif command_word == 'exit':
                return
            else:
                print("Command does not exist")
        except ValueError as ve:
            print(str(ve))


start_command()
