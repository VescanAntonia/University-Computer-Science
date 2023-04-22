# import os
#
# import django
#
# os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'A1.settings')
#
# django.setup()
#
#
# from snippets.models.TravelAgency import TravelAgency
# from snippets.models.CityBreak import CityBreak
# from snippets.models.Person import Person
# from snippets.models.CityBreakAgency import CityBreakAgency
#
#
#
#
# if __name__ == '__main__':
#     from faker import Faker
#
#     fake = Faker()
#     n = 10000
#     for _ in range(n):
#         TravelAgency.objects.create(name=fake.name(), website=fake.website(), address=fake.address(),nrOfEmployees=fake.nrOfEmployees(),nrOfOffers=fake.nrOfOffers())
#         # CityBreak.objects.create(name=fake.name(), description=fake.text(), teacher=Teacher.objects.last())
#         # Person.objects.create(first_name=fake.name(),last_name)
