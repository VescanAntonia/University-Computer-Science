"""
  Program functionalities module
    - Functions are here
    - These functions don't call other program modules
    - There is no UI ! (communicate with params / exceptions)
"""
from datetime import date
import operator


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


def add_new_expense(list_of_expenses, command_parameters):
    if command_parameters is None:
        raise ValueError("Amount of money and category requested")
    else:                                                        # displays a message if the introduced command is not
        command_parameters = command_parameters.split()                  # right or adds a new expense to the list

    if len(command_parameters) == 2:
        expense = str(get_day_of_current_day(date.today())), str(command_parameters[0]), str(command_parameters[1])
        list_of_expenses.append(expense)
    else:
        raise ValueError("Both amount of money and category of the expense must be added. ")


def choose_the_type_of_sort(list_of_expenses, command_parameters):
    if command_parameters is None:
        raise ValueError('The type of sort must be specified.')
    elif command_parameters == 'day':
        list_of_daily_expenses_in_order = determine_the_list_of_the_total_daily_expenses(list_of_expenses)
        for daily_expense in list_of_daily_expenses_in_order:
            print('The day of the expenses: '+str(daily_expense[0])+' The sum of the expenses: '+str(daily_expense[1]))
    else:
        list_of_sorted_expenses_for_given_category = determine_the_list_of_the_daily_expenses_for_given_category(
            list_of_expenses, command_parameters)
        for daily_expense_for_category in list_of_sorted_expenses_for_given_category:
            print('The day of the expenses: ' + str(daily_expense_for_category[0]) + ' The sum of the expenses: ' + str(
                daily_expense_for_category[1]))


def undo_the_last_command(list_of_expenses, list_of_the_lists_of_expenses_history):
    """
    :param list_of_expenses: the list of the expenses
    :param list_of_the_lists_of_expenses_history: a list with the lists representing the history of the operations
    :return: undo the last operation
    """
    length_of_the_history_lists = len(list_of_the_lists_of_expenses_history)
    if length_of_the_history_lists == 0:
        raise ValueError("   Cannot complete operation. Nothing to undo.")
    list_of_expenses.clear()
    for expense in list_of_the_lists_of_expenses_history[length_of_the_history_lists-1]:
        list_of_expenses.append(expense)
    list_of_the_lists_of_expenses_history.pop()


def filter_based_on_the_category(expenses, parameters):
    """
    :param expenses: list of the expenses
    :param parameters: the parameters of the operation
    :return: removes the expenses which do not meet the wanted condition
    """
    exists = 0
    for expense in expenses:
        if get_category_of_expense(expense) == parameters[0]:
            exists = 1
    if not exists:
        raise ValueError("  There is no expense with the given category. ")
    else:
        for position in range(0, len(expenses)):
            for expense in expenses:
                if not (expense[2] == parameters[0]) is True:
                    expenses.remove(expense)


def get_the_total_expense_for_the_given_category(list_of_expenses, command_parameters):
    exists = 0
    sum_of_expense = 0
    for expense in list_of_expenses:
        if get_category_of_expense(expense) == command_parameters:
            sum_of_expense += int(get_amount_of_money_expense(expense))        # counts and returns the sum of all the
            exists = 1                                                         # expenses for a given category
    if not exists:
        raise ValueError("There is no expense with the given category. ")
    return sum_of_expense


def filter_depending_on_the_amount_of_money(list_of_expenses, list_of_parameters):
    """
    It filters the expenses based on different properties and keeps only the expenses that meet the required property
    :param list_of_expenses: list of the expenses
    :param list_of_parameters: list of the parameters
    :return: the new list with the unwanted elements removed
    """
    sign_of_the_request = list_of_parameters[1]
    for i in range(0, len(list_of_expenses)):
        for expense in list_of_expenses:
            if get_category_of_expense(expense) == list_of_parameters[0]:
                if sign_of_the_request == '<' and int(get_amount_of_money_expense(expense)) >= \
                        int(list_of_parameters[2]):
                    list_of_expenses.remove(expense)
                elif sign_of_the_request == '=' and str(get_amount_of_money_expense(expense)) != \
                        str(list_of_parameters[2]):
                    list_of_expenses.remove(expense)
                elif sign_of_the_request == '>' and str(get_amount_of_money_expense(expense)) <= \
                        str(list_of_parameters[2]):
                    list_of_expenses.remove(expense)
    removes_count = 0
    for i in range(0, len(list_of_expenses)):
        for expense in list_of_expenses:
            if get_category_of_expense(expense) != list_of_parameters[0]:
                removes_count += 1
                list_of_expenses.remove(expense)
    if removes_count == len(list_of_expenses):
        raise ValueError("There is no expense with the given category. ")


def filter_the_expenses_by_user_choice(list_of_expenses, command_parameters):
    if command_parameters is None:
        raise ValueError("The type of filter must be specified. ")
    else:
        list_of_parameters = command_parameters.split()
        if len(list_of_parameters) == 1:                                             # it chooses the type of the filter
            filter_based_on_the_category(list_of_expenses, list_of_parameters)     # on the parameters the user
        else:                                                                      # introduced
            filter_depending_on_the_amount_of_money(list_of_expenses, list_of_parameters)


def determine_new_list_in_operations_history(list_of_expenses, list_of_expenses_lists_history):
    """
    :param list_of_expenses: the list of the expenses
    :param list_of_expenses_lists_history: the updated list of the history
    :return: the updated list of lists representing the changes for the expenses
    """
    list_of_expenses_lists_history.append(list_of_expenses.copy())
    return list_of_expenses_lists_history


def determine_the_day_with_maximum_expenses(expenses_list):
    """
    :param expenses_list: the list of the expenses
    :return: determines the day with the maximum expenses
    """
    day_with_the_maximum_expenses = 0
    maximum_sum_of_the_expenses = 0
    for position in range(0, len(expenses_list) - 1):
        day_of_expense = expenses_list[position][0]
        sum_of_the_expenses_for_the_given_day = 0
        for current_position in range(position, len(expenses_list)):
            if expenses_list[current_position][0] == day_of_expense:                    # counts the amount of money for
                sum_of_the_expenses_for_the_given_day += expenses_list[current_position][1]  # each day
        if sum_of_the_expenses_for_the_given_day > maximum_sum_of_the_expenses:
            maximum_sum_of_the_expenses = sum_of_the_expenses_for_the_given_day
            day_with_the_maximum_expenses = day_of_expense
    return day_with_the_maximum_expenses


def determine_the_sum_of_expenses_for_a_day(day, expenses_list):
    """
    :param day:
    :param expenses_list: the list of the expenses
    :return: calculates the sum of the expenses for a day
    """
    sum_expense = 0
    for expense in expenses_list:
        if expense[0] == day:
            sum_expense += int(expense[1])
    return sum_expense


def split_command(user_command):
    """
    Split the user's command into the command word and a parameters string
    ex:
         add 25 100 food  -> ('add', '25 100 food')
         remove 2 to 9    -> ('remove', '2 to 9')
         exit             -> ('exit', None)
    :param user_command: Command input by the user
    :return: A tuple of (<command word>, <command parameter>)
    """
    user_command = user_command.strip()
    command_words = user_command.split(maxsplit=1)
    command_word = command_words[0].lower() if len(command_words) > 0 else None
    command_parameter = command_words[1].lower() if len(command_words) == 2 else None

    return command_word, command_parameter


def determine_the_list_of_the_total_daily_expenses(list_of_expenses):
    """
    :param list_of_expenses: the list of the expenses
    :return: creates and sorts the list of the total daily expenses
    """
    list_of_the_amount_of_money_spent_daily = {}
    for expense in list_of_expenses:
        list_of_the_amount_of_money_spent_daily[expense[0]] = determine_the_sum_of_expenses_for_a_day(expense[0],
                                                                                                      list_of_expenses)
    sorted_list_of_daily_expenses = sorted(list_of_the_amount_of_money_spent_daily.items(), key=operator.itemgetter(1))
    return sorted_list_of_daily_expenses


def determine_the_list_of_the_daily_expenses_for_given_category(list_of_expenses, expense_category):
    """
    :param list_of_expenses: list of the expenses
    :param expense_category: the category of the expense
    :return: the sorted list of the daily expenses for given category
    """
    list_of_daily_expenses_for_given_category = {}
    for expense in list_of_expenses:
        if expense[2] == expense_category:
            list_of_daily_expenses_for_given_category[expense[0]] = expense[1]
    sorted_list_of_daily_expenses_for_given_category = sorted(list_of_daily_expenses_for_given_category.items(),
                                                              key=operator.itemgetter(1))
    return sorted_list_of_daily_expenses_for_given_category


def remove_expenses_from_requested_day(expenses_list, parameters):
    exists = 0
    for expense in expenses_list:
        if int(expense[0]) == int(parameters[0]):       # removes the expenses for a given day
            expenses_list.remove(expense)
            exists = 1
    if not exists:
        raise ValueError("  There are no expenses for the given day. ")


def get_the_parameters(list_parameters):
    """
    :param list_parameters: the list with the parameters
    :return: splits the parameters
    """
    parameters = [list_parameters[0]]
    list_parameters[1] = list_parameters[1].split()
    parameters.append(list_parameters[1][0])
    parameters.append(list_parameters[1][1])
    return parameters


def test_for_split_command():
    assert split_command("add 5 internet") == ("add", "5 internet")
    assert split_command("remove 13") == ("remove", "13")
    assert split_command("list") == ("list", None)
    assert split_command("list food = 5") == ("list", "food = 5")
    assert split_command("sort food") == ("sort", "food")
    assert split_command("remove 2 to 9") == ("remove", "2 to 9")
    assert split_command("INSERT 15 100 INTERNET") == ("insert", "15 100 internet")
    assert split_command("EXIT") == ("exit", None)


def test_get_day_of_current_day():
    assert get_day_of_current_day("2021-05-15") == '15'
    assert get_day_of_current_day("2017-06-10") == '10'
    assert get_day_of_current_day("2021-12-30") == '30'
    assert get_day_of_current_day("2021-07-27") == '27'
    assert get_day_of_current_day("2011-01-19") == '19'
    assert get_day_of_current_day("2009-12-24") == '24'


def test_for_getters():
    assert get_day_of_current_day((5, 20, "internet")) == 5
    assert get_day_of_current_day((15, 100, "food")) == 15
    assert get_day_of_current_day((16, 400, "clothing")) == 16
    assert get_category_of_expense((5, 100, 'food')) == 'food'
    assert get_category_of_expense((18, 70, 'housekeeping')) == 'housekeeping'
    assert get_category_of_expense((11, 40, 'transport')) == 'transport'
    assert get_amount_of_money_expense((28, 270, 'housekeeping')) == 270
    assert get_amount_of_money_expense((10, 100, 'food')) == 100
    assert get_amount_of_money_expense((22, 40, 'transport')) == 40


def test_the_undo_the_last_command():
    expenses = [(1, 15, 'internet'), (12, 50, 'transport'), (5, 100, 'food'), (18, 70, 'housekeeping')]
    assert add_new_expense(expenses, "10 internet") == [(1, 15, 'internet'), (12, 50, 'transport'), (5, 100, 'food'),
                                                        (18, 70, 'housekeeping'), (29, 10, 'internet')]
    assert undo_the_last_command(expenses, [(1, 15, 'internet'), (12, 50, 'transport'), (5, 100, 'food'),
                                            (18, 70, 'housekeeping')]) == [(1, 15, 'internet'), (12, 50, 'transport'),
                                                                           (5, 100, 'food'), (18, 70, 'housekeeping')]


def test_get_the_total_expense_for_the_given_category():
    expenses = [(1, 15, 'internet'), (12, 50, 'food'), (5, 100, 'food'),  (19, 200, 'clothing'), (11, 40, 'transport'),
                (30, 150, 'food'), (3, 40, 'internet'), (27, 80, 'healthcare'), (15, 100, 'books')]
    assert get_the_total_expense_for_the_given_category(expenses, 'food') == 300
    assert get_the_total_expense_for_the_given_category(expenses, 'internet') == 55
    assert get_the_total_expense_for_the_given_category(expenses, 'transport') == 40
    assert get_the_total_expense_for_the_given_category(expenses, 'clothing') == 200
    assert get_the_total_expense_for_the_given_category(expenses, 'healthcare') == 80
    assert get_the_total_expense_for_the_given_category(expenses, 'books') == 100


def test_determine_the_day_with_maximum_expenses():
    expenses = [(1, 15, 'internet'), (12, 50, 'food'), (5, 100, 'food'), (19, 200, 'clothing'), (11, 40, 'transport'),
                (30, 150, 'food'), (3, 40, 'internet'), (27, 80, 'healthcare')]
    assert determine_the_day_with_maximum_expenses(expenses) == 19
    expenses = [(1, 15, 'internet'), (12, 50, 'food'), (5, 100, 'food'), (29, 200, 'clothing'), (11, 40, 'transport'),
                (30, 150, 'food'), (3, 40, 'internet'), (27, 80, 'healthcare')]
    assert determine_the_day_with_maximum_expenses(expenses) == 29
    expenses = [(1, 15, 'internet'), (12, 50, 'food'), (5, 100, 'food'), (11, 40, 'transport'),
                (30, 150, 'food'), (3, 40, 'internet'), (27, 80, 'healthcare')]
    assert determine_the_day_with_maximum_expenses(expenses) == 30
    expenses = [(1, 15, 'internet'), (12, 50, 'food'), (5, 100, 'food'), (11, 40, 'transport'),
                (11, 250, 'food'), (3, 40, 'internet'), (27, 80, 'healthcare')]
    assert determine_the_day_with_maximum_expenses(expenses) == 11
    expenses = [(1, 15, 'internet'), (12, 50, 'food'), (5, 100, 'food'), (11, 40, 'transport'),
                (5, 10, 'food'), (3, 40, 'internet'), (27, 80, 'healthcare')]
    assert determine_the_day_with_maximum_expenses(expenses) == 5


test_determine_the_day_with_maximum_expenses()
test_get_the_total_expense_for_the_given_category()
test_get_day_of_current_day()
test_for_split_command()
