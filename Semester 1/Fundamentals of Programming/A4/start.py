"""
  Start the program by running this module
  These functions can call functions from board
    There is no UI ! (communicate with params / exceptions)No UI
"""


from functions import split_the_parameters, remove_expenses_from_requested_day,\
    get_category_of_expense, get_day_of_expense


def determine_the_property_the_user_chose(command_parameters):
    """
    :param command_parameters: the parameters of the command
    :return: the property the user chose
    """
    the_chosen_property = 0
    if command_parameters is None:
        the_chosen_property = 1
    else:
        parameters = split_the_parameters(command_parameters)
        if len(parameters) == 1:
            the_chosen_property = 2
        elif len(parameters) == 2:
            the_chosen_property = 3
    return the_chosen_property


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


def remove_expenses_for_a_requested_interval(list_of_expenses, parameters_choice):
    exists = 0
    for element in list_of_expenses:
        if int(parameters_choice[0]) <= int(get_day_of_expense(element)) <= int(parameters_choice[2]):
            list_of_expenses.remove(element)                     # removes the expenses for a given interval of days
            exists = 1
    if not exists:
        raise ValueError("  There are no expenses for the given interval. ")


def remove_expenses_from_requested_category(list_of_expenses, parameters_choice):
    exists = 0
    for element in list_of_expenses:
        if get_category_of_expense(element) == parameters_choice[0]:        # removes the expenses for a given category
            list_of_expenses.remove(element)
            exists = 1
    if not exists:
        raise ValueError("  There are no expenses for the given category. ")


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
        expense = str(command_parameters[0]), command_parameters[1], str(command_parameters[2])
        list_of_expenses.append(expense)
