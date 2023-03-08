from repository.repository import Repository
from service.service import Service
from ui.ui import GameUi

repository = Repository()
service = Service(repository)
Ui = GameUi(service)
Ui.start_the_game()
