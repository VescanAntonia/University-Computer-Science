from src.domain.domain import Book


class Service:
    def __init__(self):
        self.book_list = []
        self.book_list_for_undo = []

    def generate_books(self):
        self.book_list.append(Book(98, "Marcel Proust", "In Search of Lost Time"))
        self.book_list.append(Book(55, "Miguel de Cervantes", "Don Quixote"))
        self.book_list.append(Book(72, "F. Scott Fitzgerald", "The Great Gatsby"))
        self.book_list.append(Book(19, "Leo Tolstoy", "War and Peace"))
        self.book_list.append(Book(15, "Homer", "The Odyssey"))
        self.book_list.append(Book(27, "Fyodor Dostoevsky", "Crime and Punishment"))
        self.book_list.append(Book(39, "Jane Austen", "Pride and Prejudice"))
        self.book_list.append(Book(12, "Homer", "The Iliad"))
        self.book_list.append(Book(87, "Ralph Ellison", "Invisible Man"))
        self.book_list.append(Book(107, "Ernest Hemingway", "The Old Man and the Sea"))

    # getters for the books

    def get_books(self):
        return self.book_list

    def search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(self, book_isbn):
        if not isinstance(book_isbn, int) or int(book_isbn) < 0:
            raise ValueError("The isbn of the book is invalid")
        exists = False
        for book in self.book_list:
            if book_isbn == book.get_isbn:
                exists = True
        return exists

    def add_book(self, isbn, author, title):
        if not isinstance(isbn, int) or int(isbn) < 0:
            raise ValueError("The isbn of the book is invalid")
        if not (author.isalpha() or title.isalpha()):
            raise ValueError("Both author and title of the book must be valid words")
        if not self.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(isbn):
            self.book_list.append(Book(isbn, author, title))
        else:
            raise ValueError("There already exists a book with this isbn!")

    def delete_books_that_start_with_a_given_word(self, word):
        exists = False
        for i in range(0, 2 * len(self.book_list) + 1):
            for book in self.book_list:
                if book.get_title.startswith(word):
                    self.book_list.remove(book)
                    exists = True
        if not exists:
            raise ValueError("There is no book that starts with the given word. ")


def test_for_uniqueness__unique_true():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(55) == True


test_for_uniqueness__unique_true()


def test_for_uniqueness__unique2_true():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(107) == True


test_for_uniqueness__unique2_true()


def test_for_uniqueness__unique3_true():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(72) == True


test_for_uniqueness__unique3_true()


def test_for_uniqueness__unique4_true():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(19) == True


test_for_uniqueness__unique4_true()


def test_for_uniqueness__not_unique_false():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(106) == False


test_for_uniqueness__not_unique_false()


def test_for_uniqueness__not_unique2_false():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(106) == False


test_for_uniqueness__not_unique2_false()


def test_for_uniqueness__not_unique3_false():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(57) == False


test_for_uniqueness__not_unique3_false()


def test_for_uniqueness__not_unique4_false():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    assert function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(99) == False


test_for_uniqueness__not_unique4_false()


def test_for_uniqueness__some_isbn_throws_exception():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    try:
        function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness("abc")
        assert False
    except ValueError as ve:
        assert str(ve)


test_for_uniqueness__some_isbn_throws_exception()


def test_for_uniqueness__some_isbn2_throws_exception():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()
    try:
        function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness(-55)
        assert False
    except ValueError as ve:
        assert str(ve)


test_for_uniqueness__some_isbn2_throws_exception()


def test_for_uniqueness__some_isbn3_throws_exception():
    function_uniqueness_to_test = Service()
    function_uniqueness_to_test.generate_books()
    function_uniqueness_to_test.get_books()

    try:
        function_uniqueness_to_test.search_if_there_is_a_book_with_the_same_isbn_for_uniqueness("m")
        assert False
    except ValueError as ve:
        assert str(ve)


test_for_uniqueness__some_isbn3_throws_exception()


def add_book__added__true():
    function_add_to_test = Service()
    initial_length_of_the_list = len(function_add_to_test.book_list)
    function_add_to_test.add_book(177, "Sophocles", "Electra")


add_book__added__true()


def add_book__added2__true():
    function_add_to_test = Service()
    initial_length_of_the_list = len(function_add_to_test.book_list)
    function_add_to_test.add_book(67, " Frank Herbert", "Dune")
    assert initial_length_of_the_list + 1 == len(function_add_to_test.book_list)


add_book__added2__true()


def add_book__added4__true():
    function_add_to_test = Service()
    initial_length_of_the_list = len(function_add_to_test.book_list)
    function_add_to_test.add_book(21, "Renata Adler", "Speedboat")
    assert initial_length_of_the_list+1 == len(function_add_to_test.book_list)


add_book__added4__true()

def add_book_book_throws_TypeError():
    function_add_to_test = Service()

    try:
        function_add_to_test.add_book(-4, "Ernest Hemingway", "The Old Man and the Sea")
        assert False
    except ValueError as ve:
        assert str(ve)


add_book_book_throws_TypeError()


def add_book_book_throws2_TypeError():
    function_add_to_test = Service()

    try:
        function_add_to_test.add_book(55, "Miguel de Cervantes", "Don Quixote")
        assert False
    except ValueError as ve:
        assert str(ve)


add_book_book_throws2_TypeError()


def add_book_book_throws3_TypeError():
    function_add_to_test = Service()

    try:
        function_add_to_test.add_book(55, "Miguel de Cervantes", "Don Quixote")
        assert False
    except ValueError as ve:
        assert str(ve)


add_book_book_throws3_TypeError()


def add_book_book_throws4_TypeError():
    function_add_to_test = Service()
    try:
        function_add_to_test.add_book("Ernest Hemingway", "Ernest Hemingway", 7)
        assert False
    except ValueError as ve:
        assert str(ve)


add_book_book_throws4_TypeError()


def delete_the_books_for_given_word__deleted_true():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()
    function_remove_to_test.delete_books_that_start_with_a_given_word('The')
    assert len(function_remove_to_test.book_list) == 6


delete_the_books_for_given_word__deleted_true()


def delete_the_books_for_given_word__deleted_true():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()
    function_remove_to_test.delete_books_that_start_with_a_given_word('Don')
    assert len(function_remove_to_test.book_list) == 9


delete_the_books_for_given_word__deleted_true()


def delete_the_books_for_given_word2__deleted_true():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()
    function_remove_to_test.delete_books_that_start_with_a_given_word('In')
    assert len(function_remove_to_test.book_list) == 8

delete_the_books_for_given_word2__deleted_true()


def delete_the_books_for_given_word3__deleted_true():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()
    function_remove_to_test.delete_books_that_start_with_a_given_word('War and Peace')
    assert len(function_remove_to_test.book_list) == 9


delete_the_books_for_given_word3__deleted_true()


def delete_the_books_for_given_word4__deleted_true():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()
    function_remove_to_test.delete_books_that_start_with_a_given_word('C')
    assert len(function_remove_to_test.book_list) == 9


delete_the_books_for_given_word4__deleted_true()


def delete_the_books_for_given_word5__deleted_true():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()
    function_remove_to_test.delete_books_that_start_with_a_given_word('Pride and')
    assert len(function_remove_to_test.book_list) == 9


delete_the_books_for_given_word5__deleted_true()


def delete_the_books_for_given_word__deleted_typeerror():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()
    try:
        function_remove_to_test.delete_books_that_start_with_a_given_word('A')
        assert False
    except ValueError as ve:
        assert str(ve)


delete_the_books_for_given_word__deleted_typeerror()


def delete_the_books_for_given_word2__deleted_typeerror():
    function_remove_to_test = Service()
    function_remove_to_test.generate_books()
    function_remove_to_test.get_books()

    try:
        function_remove_to_test.delete_books_that_start_with_a_given_word('m')
        assert False
    except ValueError as ve:
        assert str(ve)


delete_the_books_for_given_word2__deleted_typeerror()




