from repo_quiz.repository_quiz import RepositoryQuiz
from service_quiz.service_quiz import ServiceQuiz
from ui_quiz.ui_quiz import GameUi

repository = RepositoryQuiz('question.txt')
service= ServiceQuiz(repository)
ui= GameUi(service)
ui.start()