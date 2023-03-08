from src.services.movieService import MovieService
from src.services.clientService import ClientService
from src.services.rentalService import RentalService
from src.services.undoService import UndoService
from src.ui.UI import UI
from src.domain.movie import Movie
from src.domain.client import Client
from src.domain.rental import Rental
from src.repository.undoRepository import UndoRepository
from src.repository.movieRepository import FileTextMovieRepository, MovieRepository, FileBinaryMovieRepository
from src.repository.rentalRepository import RentalRepository, FileBinaryRentalRepository, FileTextRentalRepository
from src.repository.clientRepository import ClientRepository, FileBinaryClientRepository, FileTextClientRepository


def setting_properties():
    file_name = "settings.properties"
    movie_repository = None
    client_repository = None
    rental_repository = None
    with open(file_name, "r") as f:
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
            print(5)


            # for line in f.readlines():
            #     line = line.strip()
            #     line = line.strip("\n")
            #     repository, name = line.split("=")
            #     if repository == "movies.bin":
            #         movie_repository = FileMovieRepository("movies.bin")
            #     elif repository == "clients.bin":
            #         client_repository = FileClientRepository("clients.bin")
            #     elif repository == "rentals.bin":
            #         rental_repository = FileRentalRepository("rentals.bin")
    undo_repository = UndoRepository()
    movie_service = MovieService(movie_repository)
    client_service = ClientService(client_repository)
    rental_service = RentalService(rental_repository)
    undo_service = UndoService(undo_repository, movie_service, client_service, rental_service)

    ui = UI(movie_service, client_service, rental_service, undo_service)
    ui.start()


setting_properties()
