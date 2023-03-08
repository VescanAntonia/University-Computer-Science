class Book:
    def __init__(self, isbn, author, title):
        isbn = int(isbn)
        self.__book_isbn = isbn
        self.__book_author = author
        self.__book_title = title

    # properties
    @property
    def get_isbn(self):
        return self.__book_isbn

    @property
    def get_author(self):
        return self.__book_author

    @property
    def get_title(self):
        return self.__book_title

    def __str__(self):
        return "Book isbn: " + str(self.__book_isbn) + "   Author: " + str(self.__book_author) + "  Title: " +\
               str(self.__book_title)


def test_book():
    book_to_test = Book(100, "Marcel Proust", "In Search of Lost Time")
    assert book_to_test.get_isbn == 100
    assert book_to_test.get_author == "Marcel Proust"
    assert book_to_test.get_title == "In Search of Lost Time"

    book_to_test = Book(72, "F. Scott Fitzgerald", "The Great Gatsby")
    assert book_to_test.get_isbn == 72
    assert book_to_test.get_author == "F. Scott Fitzgerald"
    assert book_to_test.get_title == "The Great Gatsby"

    book_to_test = Book(177, "Sophocles", "Electra")
    assert book_to_test.get_isbn == 177
    assert book_to_test.get_author == "Sophocles"
    assert book_to_test.get_title == "Electra"

    book_to_test = Book(21, "Henrik Ibsen", "A Doll's House")
    assert book_to_test.get_isbn == 21
    assert book_to_test.get_author == "Henrik Ibsen"
    assert book_to_test.get_title == "A Doll's House"

    book_to_test = Book(67, " Frank Herbert", "Dune")
    assert book_to_test.get_isbn == 67
    assert book_to_test.get_author == " Frank Herbert"
    assert book_to_test.get_title == "Dune"

    book_to_test = Book(71, "Alexandre Dumas", "The Three Musketeers")
    assert book_to_test.get_isbn == 71
    assert book_to_test.get_author == "Alexandre Dumas"
    assert book_to_test.get_title == "The Three Musketeers"

    book_to_test = Book(44, "William Faulkner", "Light in August")
    assert book_to_test.get_isbn == 44
    assert book_to_test.get_author == "William Faulkner"
    assert book_to_test.get_title == "Light in August"

    book_to_test = Book(28, "H. G. Wells", "The Time Machine")
    assert book_to_test.get_isbn == 28
    assert book_to_test.get_author == "H. G. Wells"
    assert book_to_test.get_title == "The Time Machine"


test_book()
