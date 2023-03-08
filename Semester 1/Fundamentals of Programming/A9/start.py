from src.services.movieService import MovieService
from src.services.clientService import ClientService
from src.services.rentalService import RentalService
from src.services.undoService import UndoService
from src.ui.UI import UI
from src.domain.movie import Movie
from src.domain.client import Client
from src.domain.rental import Rental
from settingsModule import Settings
from src.repository.undoRepository import UndoRepository


functions = Settings("settings.properties")
movie_repository, client_repository, rental_repository = functions.analyse_file()

undo_repository = UndoRepository()
movie_service = MovieService(movie_repository)
client_service = ClientService(client_repository)
rental_service = RentalService(rental_repository)
undo_service = UndoService(undo_repository, movie_service, client_service, rental_service)

ui = UI(movie_service, client_service, rental_service, undo_service)
ui.start()
