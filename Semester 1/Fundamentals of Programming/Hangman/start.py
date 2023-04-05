from repository.repository import Repository
from service.service import Service
from ui.ui import GameUi

repository = Repository('sentences.txt')
service = Service(repository)
ui = GameUi(service)
ui.start()