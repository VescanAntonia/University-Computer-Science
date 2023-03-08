# Write the implementation for A2 in this file
"""
Non-UI
"""


def init_numbers():
    """
    Create a few test complex numbers
    :return: The list of the created numbers
    """
    return [create_number(3, 1), create_number(4, 5), create_number(6, 0), create_number(8, 8), create_number(9, 2),
            create_number(5, 3), create_number(4, 2), create_number(4, 2), create_number(3, 5), create_number(2, 7)]


def create_number(x , y):
    """
    :param x: the real part of the complex number
    :param y: the imaginary part of the complex number
    :return:
    """
    return [x, y]


def get_real_part(number):
    return number[0]   # returns the real part of the number


def get_imaginary_part(number):
    return number[1]  # returns the imaginary part of the number


def create_sequence1(listnr):
    """
    Determine the longest sequence with a strictly increasing real part.
    :param listnr:is the list of the complex numbers
    :return: the start and the end of the sequence with the given property
    """
    position1 = 0
    lgh = 0
    j = 0
    sequence_max = 0
    inferior_position = 0
    superior_position = 0
    for j in range(0, 8):
        if get_real_part(listnr[j]) < get_real_part(listnr[j+1]):  # checks whether or not the real part of the current
            lgh = lgh + 1                                          # is smaller than the following one and adds 1 to the
        else:                                                      # counter if it is
            if lgh > sequence_max:                                 # if not the program checks if the current sequence
                sequence_max = lgh                                 # longer than the longest one and resets the
                inferior_position = position1                      # variables
                superior_position = j
    if lgh > sequence_max:
        sequence_max = lgh                                         # the comparison is repeated once it gets out of the
        inferior_position = position1                              # cycle to ensure that the longest sequence is not
        superior_position = j                                      # ending on the last position
    return [inferior_position, superior_position]


def add_number(numbers, number):
    """
    Adds a given number to the list
    :param numbers: the list of the complex numbers
    :param number: the number which needed to be added to the list
    :return:
    """
    numbers.append(number)


def create_sequence2(values):
    """
    :param values: the list of the numbers
    :return: the new list
    """
    array = {}
    index = 1                                                # creates a new list that contains the real part and the
    for value in values:                                     # imaginary part of the numbers in order to compare them
        array[index] = int(str(get_real_part(value)) + str(get_imaginary_part(value)))   # and determine the longest
        index = index + 1                                    # sequence which has the property
    return array


def longest_sequence_3distinct(list):
    """
    Determines the longest sequence that contains at most 3 distinct values
    :param list: the complex numbers
    :return: the first and the last element of the largest sequence with the given property
    """
    n = len(list)
    first = 0
    last = 0
    seq_max = 0
    for i in range(1, n):
        k = 0
        j = i
        seq = 0
        start1 = i
        different = 0
        while j < n and different <= 3:                                        # checks there are already 3 numbers in
            seq = seq+1                                          # current sequence and continues to count the numbers
            if different == 3 and list[i] != list[i + 1]:        # in the sequence if there are no conditions that
                k = 1                                            # stops it
            if list[i] != list[i+1]:
                different = different+1
            if seq > seq_max and k != 1:
                seq_max = seq
                first = start1
                last = j
            j = j+1
    return [first-1, last]                               # returns position of the sequence's ends



""""
UI section
"""""


def add_complex_number(numbers_list):
    """
    Provides the user with the parts of the complex number that should be added
    :param numbers_list: the list of the complex numbers
    :return: A message if the number is added successfully
    """
    number_a = int(input("Enter a="))         # gets the real part from the console
    number_b = int(input("Enter b="))         # gets the imaginary part from the console
    number = create_number(number_a, number_b)    # creates the complex number with the given parts
    add_number(numbers_list, number)              # appeals the function that  should add the new number
    print("Number added successfully")            # prints an appropriate message for the user


def generate_sequence2(elements):
    """
    Displays the longest sequence that contains at most 3 distinct values
    :param elements: the entire list of the numbers
    :return: the numbers that are included in the sequence
    """
    ends = longest_sequence_3distinct(create_sequence2(elements))      # gets the ends of the sequence
    print("The longest sequence that contains at most 3 distinct values.")
    for m in range(ends[0], ends[1]):
            print(str(get_real_part(elements[m]))+'+' + str(get_imaginary_part(elements[m]))+'i ')


def generate_sequence1(list):
    """
    Displays the longest sequence with a strictly increasing real part
    :param list: the list of the numbers
    :return: the numbers included in the sequence with the given property
    """
    pointers = create_sequence1(list)     # gets the ends of the sequence
    print("The longest sequence with a strictly increasing real part.")
    for i in range(pointers[0], pointers[1]):
        if str(get_imaginary_part(list[i])) > '0':
            print(str(get_real_part(list[i]))+'+' + str(get_imaginary_part(list[i]))+'i ')
        else:
            print(str(get_real_part(list[i])))


def display_the_numbers(numbers):
    """
    :param numbers: the list of the complex numbers
    :return: displays the entire list of the numbers on the console
    """
    count = 1
    for number in numbers:  # covers the list of the numbers
        if get_imaginary_part(number) != 0:
            print(str(count)+'.Real part: ' + str(get_real_part(number))+' Imaginary part: ' +
              str(get_imaginary_part(number)) + 'i')
        else:
            print(str(count) + '.Real part:  ' + str(get_real_part(number)) + ' Imaginary part: ' +
                  str(get_imaginary_part(number)))
        count = count+1


def print_menu():
    """
    :return: generates the menu from which the user can choose
    """
    print("1. Add a complex number")
    print("2. Display the list of numbers")
    print("3. Display the longest sequence with a strictly increasing real part.")
    print("4. Display the longest sequence that contains at most 3 distinct values.")
    print("5. Exit")


def start():
    numbers_list = init_numbers()
    while True:
        print_menu()
        option = input("Enter your option: ")
        if option == '1':
            add_complex_number(numbers_list)
        elif option == '2':
            display_the_numbers(numbers_list)
        elif option == '3':
            generate_sequence1(numbers_list)
        elif option == '4':
            generate_sequence2(numbers_list)
        elif option == '5':
            return
        else:
            print("Option not available")


start()





