"""
    User interface module
    Can call functions from functions/start
    All input/print statements go here
"""


from functions import get_category_of_expense, get_amount_of_money_expense, get_day_of_expense,\
    init_list_of_expenses, split_command,  determine_the_day_with_maximum_expenses, undo_the_last_command,\
    determine_new_list_in_operations_history,  get_the_parameters, get_the_total_expense_for_the_given_category,\
    filter_the_expenses_by_user_choice, add_new_expense, choose_the_type_of_sort
from start import determine_the_property_the_user_chose,\
    remove_the_user_choices, insert_expense


def calculate_total_expense_for_category(list_of_expenses, command_parameters):
    if command_parameters is None:
        raise ValueError("The category of the expense must be added")      # returns the sum of expenses for a given
    else:                                                                  # category
        total_expense_for_given_category = get_the_total_expense_for_the_given_category(list_of_expenses,
                                                                                        command_parameters)
        print('The sum of expenses for the '+command_parameters+' is: '+str(total_expense_for_given_category))


def display_the_day_with_maximum_expenses(expenses_list):
    the_day_with_maximum_expenses = determine_the_day_with_maximum_expenses(expenses_list)   # determines and displays
    print('The day with the maximum expenses is: '+str(the_day_with_maximum_expenses))  # the day with maximum expenses


def display_the_list_of_expenses(list_of_expenses, command_parameters):
    the_property = determine_the_property_the_user_chose(command_parameters)
    if the_property == 1:
        i = 1
        for expense in list_of_expenses:
            print(str(i) + '.Day: ' + str(get_day_of_expense(expense)) + ' Amount of money: ' +
                  str(get_amount_of_money_expense(expense)) + ' Category: ' + get_category_of_expense(expense))
            i = i + 1
    elif the_property == 2:
        for element in list_of_expenses:
            if get_category_of_expense(element) == command_parameters:  # lists all the expenses for a given category
                print('Day: ' + str(get_day_of_expense(element)) + ' Amount of money: ' +
                      str(get_amount_of_money_expense(element)) + ' Category: ' + get_category_of_expense(element))
    elif the_property == 3:
        parameters = command_parameters.split()
        exists = False
        for expense in list_of_expenses:
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


def display_expenses_for_given_money_ui(list_expenses, list_parameters):
    """
    :param list_expenses: the list of the expenses
    :param list_parameters: representing the category of the new expense and the property it has
    :return: displays on the console the expenses which meet the conditions or a specific message if there are not
            expenses with the given property
    """
    parameters = get_the_parameters(list_parameters)
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
        print(str(i) + '.Day: ' + str(get_day_of_expense(expense)) + ' Amount of money: ' +
              str(get_amount_of_money_expense(expense)) + ' Category: ' + get_category_of_expense(expense))
        i = i + 1


def display_all_for_given_category(list_of_expenses, category):
    for element in list_of_expenses:
        if get_category_of_expense(element) == category:           # lists all the expenses for a given category
            print('.Day: ' + str(get_day_of_expense(element))+' Amount of money: ' +
                  str(get_amount_of_money_expense(element)) + ' Category: ' + get_category_of_expense(element))


def print_menu():
    print("\tAvailable options: ")
    print("\t  Add a new expense")
    print("\t  Remove expenses")
    print("\t  Display expenses with different properties")
    print("\t  Obtain a sublist based on given characteristics")
    print("\t  Filter expenses")
    print("\t  Undo")
    print("\t  Exit")


def start_command():
    """
    Start command-based UI
    <command word> <command parameters>
    """
    list_of_expenses = init_list_of_expenses()
    print_menu()
    list_of_the_lists_of_expenses_history = []
    while True:
        command = input("Enter your command: ")
        command_word, command_parameters = split_command(command)

        try:
            if command_word == 'list':
                display_the_list_of_expenses(list_of_expenses, command_parameters)
            elif command_word == 'sum':
                calculate_total_expense_for_category(list_of_expenses, command_parameters)
            elif command_word == 'max':
                display_the_day_with_maximum_expenses(list_of_expenses)
            elif command_word == 'sort':
                determine_new_list_in_operations_history(list_of_expenses, list_of_the_lists_of_expenses_history)
                choose_the_type_of_sort(list_of_expenses, command_parameters)
            elif command_word == 'filter':
                determine_new_list_in_operations_history(list_of_expenses, list_of_the_lists_of_expenses_history)
                filter_the_expenses_by_user_choice(list_of_expenses, command_parameters)
                print("Expenses filtered successfully!")
            elif command_word == 'undo':
                undo_the_last_command(list_of_expenses, list_of_the_lists_of_expenses_history)
                print("   Undo operation done successfully!")
            elif command_word == 'remove':
                determine_new_list_in_operations_history(list_of_expenses, list_of_the_lists_of_expenses_history)
                remove_the_user_choices(list_of_expenses, command_parameters)
                print("Expense removed successfully!")
            elif command_word == 'add':
                determine_new_list_in_operations_history(list_of_expenses, list_of_the_lists_of_expenses_history)
                add_new_expense(list_of_expenses, command_parameters)
                print("Expense added successfully!")
            elif command_word == 'insert':
                determine_new_list_in_operations_history(list_of_expenses, list_of_the_lists_of_expenses_history)
                insert_expense(list_of_expenses, command_parameters)
                print("Expense added successfully!")
            elif command_word == 'exit':
                return
            else:
                print("Command does not exist")
        except ValueError as ve:
            print(str(ve))


start_command()
