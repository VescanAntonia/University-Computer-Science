from django.test import TestCase
from snippets.models.TravelAgency import TravelAgency
from snippets.models.CityBreak import CityBreak
from snippets.models.CityBreakAgency import CityBreakAgency


class CityBreakByNoOtherAgenciesContract(TestCase):
    @classmethod
    def setUpTestData(cls):
        one_c = CityBreak.objects.create(country='Italy', city='Rome', hotel='Grand Hotel', price=520, transport='plane')
        two_c = CityBreak.objects.create(country='Spain', city='Madrid', hotel='Blue Hotel', price=250, transport='plane')
        three_c = CityBreak.objects.create(country='Romania', city='Brasov', hotel='Bran Hotel', price=300,transport='bus')
        four_c = CityBreak.objects.create(country='Croatia', city='Zagreb', hotel='Sunny Hotel', price=400,transport='train')
        one_t = TravelAgency.objects.create(name='gama', website='www.gama.com', address='str.Fabricii,nr5',nrOfEmployees=150, nrOfOffers=520)
        two_t = TravelAgency.objects.create(name='ztour', website='www.ztour.com', address='str.Memorandumului,nr.6',nrOfEmployees=200, nrOfOffers=500)
        three_t = TravelAgency.objects.create(name='Jubel', website='www.jubel.com', address='3917 Marion Street',nrOfEmployees=700, nrOfOffers=1000)
        CityBreakAgency.objects.create(creatingDate='2022-02-15', enrollmentDeadline='2022-03-20', cityBreak=one_c,agency=one_t)
        CityBreakAgency.objects.create(creatingDate='2022-10-24', enrollmentDeadline='2022-11-25', cityBreak=two_c,agency=one_t)
        CityBreakAgency.objects.create(creatingDate='2022-10-24', enrollmentDeadline='2022-11-25', cityBreak=two_c,agency=two_t)

        CityBreakAgency.objects.create(creatingDate='2023-02-10', enrollmentDeadline='2023-03-15', cityBreak=three_c,agency=three_t)
        CityBreakAgency.objects.create(creatingDate='2023-02-10', enrollmentDeadline='2023-03-15', cityBreak=three_c,agency=two_t)
        CityBreakAgency.objects.create(creatingDate='2023-01-15', enrollmentDeadline='2023-02-17', cityBreak=four_c,agency=three_t)

    def test_citybreak_by_no_other_agencies(self):
        response = self.client.get("/snippets/cit/by-other-agencies-contract/")
        self.assertEqual(len(response.data),3)
        first=response.data[0]['country']
        first_no_other_agencies=response.data[0]['num_other_agencies']
        self.assertEqual(first,'Spain')
        self.assertEqual(first_no_other_agencies,1)

    def test_string_method_citybreak(self):
        citybreak = CityBreak.objects.get(country='Italy')
        expected_string = "Italy"
        self.assertEqual(str(citybreak), expected_string)

    def test_string_method_travelagency(self):
        travelagency = TravelAgency.objects.get(name="gama")
        expected_string = "gama"
        self.assertEqual(str(travelagency), expected_string)

    def test_string_method_citagency(self):
        citAgency = CityBreakAgency.objects.get(agency=2,cityBreak=3)
        expected_string = "Romania-ztour"
        self.assertEqual(str(citAgency), expected_string)
