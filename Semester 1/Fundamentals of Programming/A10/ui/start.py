from domain.movie import Movie
from domain.client import Client
from services.movieService import MovieService
from services.clientService import ClientService
from services.rentalService import RentalService
from services.undoService import UndoService
from ui.UI import UI
from repository.undoRepository import UndoRepository
from repository.movieRepository import MovieRepository
from repository.rentalRepository import RentalRepository
from repository.clientRepository import ClientRepository
from domain.rental import Rental

movie_repository = MovieRepository()
client_repository = ClientRepository()
rental_repository = RentalRepository()
undo_repository = UndoRepository()


movie_service = MovieService(movie_repository)
client_service = ClientService(client_repository)
rental_service = RentalService(rental_repository)
undo_service = UndoService(undo_repository, movie_service, client_service, rental_service)


ui = UI(movie_service, client_service, rental_service, undo_service)
ui.start()
