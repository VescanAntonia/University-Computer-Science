from repository.repository_achi import Repository
from ui.ui import GameUi
from service.service import Service

repository = Repository()
service = Service(repository)
ui = GameUi(service)

ui.start()