from src.repository.movieRepository import FileTextMovieRepository, MovieRepository, FileBinaryMovieRepository, FileJsonRepositoryMovie
from src.repository.rentalRepository import RentalRepository, FileBinaryRentalRepository, FileTextRentalRepository, FileJsonRepositoryRental
from src.repository.clientRepository import ClientRepository, FileBinaryClientRepository, FileTextClientRepository, FileJsonRepositoryClient


class Settings:
    def __init__(self, file_name):
        self._file_name = file_name

    def analyse_file(self):
        movie_repository = None
        client_repository = None
        rental_repository = None
        with open(self._file_name, "r") as f:
            line = f.readline()
            line = line.strip("\n")
            repository, type = line.split("=")
            if type == "text":
                for line in f.readlines():
                    line = line.strip()
                    line = line.strip("\n")
                    repository, name = line.split("=")
                    if name == "movies.txt":
                        movie_repository = FileTextMovieRepository("movies.txt")
                    elif name == "clients.txt":
                        client_repository = FileTextClientRepository("clients.txt")
                    elif name == "rentals.txt":
                        rental_repository = FileTextRentalRepository("rentals.txt")
            elif type == "in_memory":
                movie_repository = MovieRepository()
                client_repository = ClientRepository()
                rental_repository = RentalRepository()
            elif type == "binary":
                for line in f.readlines():
                    line = line.strip()
                    line = line.strip("\n")
                    repository, name = line.split("=")
                    if name == "movies.bin":
                        movie_repository = FileBinaryMovieRepository("movies.bin")
                    elif name == "clients.bin":
                        client_repository = FileBinaryClientRepository("clients.bin")
                    elif name == "rentals.bin":
                        rental_repository = FileBinaryRentalRepository("rentals.bin")
            elif type == "json":
                for line in f.readlines():
                    line = line.strip()
                    line = line.strip("\n")
                    repository, name = line.split("=")
                    if name == "movies.json":
                        movie_repository = FileJsonRepositoryMovie("movies.json")
                    elif name == "clients.json":
                        client_repository = FileJsonRepositoryClient("clients.json")
                    elif name == "rentals.json":
                        rental_repository = FileJsonRepositoryRental("rentals.json")
            return movie_repository, client_repository, rental_repository