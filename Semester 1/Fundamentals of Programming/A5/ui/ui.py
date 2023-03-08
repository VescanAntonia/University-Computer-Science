# from src.services.services import Service
#
#
# class Ui:
#     def __init__(self):
#         self._function = Service()
#
#     def generate_books(self):
#         self._function.generate_books()
#
#     def show_menu(self):
#         print("1. Add a book. ")
#         print("2. Display the list of books.  ")
#         print("3. Filter the list of the books. ")
#         print("4. Undo the last operation that modified program data. ")
#         print("5. Exit.")
#
#     def user_input_with_book_information_to_add(self):
#         try:
#             new_book_isbn = int(input('   The book isbn: '))
#             new_book_author = input('   The book author: ')
#             new_book_title = input('   The book title: ')
#             self._function.add_book(new_book_isbn, new_book_author, new_book_title)
#             print("   Book added successfully!")
#         except ValueError as ve:
#             print(str(ve))
#
#     def display_the_books(self):
#         list_of_books = self._function.get_books()
#         for book in list_of_books:
#             print(str(book))
#
#     def delete_books(self):
#         try:
#             given_word = (input('   Enter the prefix the deleted books should have: '))
#         except ValueError as ve:
#             print(str(ve))
#         self._function.delete_books_that_start_with_a_given_word(given_word)
#
#     def start(self):
#         self.generate_books()
#         self._function.book_list_for_undo = []
#         self._function.book_list_for_undo.append(self._function.book_list[:])
#         while True:
#             self.show_menu()
#             user_option = input("   Enter your option: ")
#             try:
#                 if user_option == '1':
#                     self._function.book_list_for_undo.append(self._function.book_list[:])
#                     self.user_input_with_book_information_to_add()
#                 elif user_option == '2':
#                     self.display_the_books()
#                 elif user_option == '3':
#                     self._function.book_list_for_undo.append(self._function.book_list[:])
#                     self.delete_books()
#                     print("   Books filtered successfully!")
#                 elif user_option == '4':
#                     if len(self._function.book_list_for_undo) > 1:
#                         self._function.book_list = self._function.book_list_for_undo[len(self._function.
#                                                                                          book_list_for_undo) - 1]
#                         self._function.book_list_for_undo.pop(len(self._function.book_list_for_undo) - 1)
#                         print("   Undo operation done successfully!")
#                     else:
#                         print("   Cannot complete operation. Nothing to undo.")
#                 elif user_option == '5':
#                     return
#                 else:
#                     print("   The option does not exist. ")
#             except ValueError as ve:
#                 print(str(ve))
#
#
# main = Ui()
# main.start()
from random import choice
list_of = [("msms", "5"), ("ma", "4")]
x = choice(list_of)
print(x)
