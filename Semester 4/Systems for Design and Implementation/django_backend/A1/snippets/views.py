# from django.shortcuts import render
#
# # Create your views here.
# # from django.db.models import Avg,Count,OuterRef
# #
# # from rest_framework.response import Response
# # from rest_framework.decorators import api_view
# # from rest_framework import status
# # from rest_framework import generics
# # from rest_framework.views import APIView
# # from django.shortcuts import render
# # from django.http import JsonResponse, HttpResponse
# # from snippets.models import CityBreak,Person,TravelAgency
# # from snippets.serializers import CityBreakSerializer,PersonSerializer,TravelAgencySerializer,PersonSerializerIds,TravelAgencySerializerIds
# # from snippets.serializers import CityBreakAgencySerializer
# # from snippets.models import CityBreakAgency
#
#
#
#
# class CityBreaksDetail(APIView):
#     def get(self, request):
#         #obj=CityBreak.objects.all().values_list('id',flat=True)
#         obj = CityBreak.objects.all()
#         serializer = CityBreakSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = CityBreakSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#
# class CityBreaksInfo(APIView):
#
#     def get(self,request):
#         try:
#             obj = CityBreak.objects.get(id=id)
#         except CityBreak.DoesNotExist:
#             msg = {"msg": "not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#
#         serializer=CityBreakSerializer(obj)
#         return Response(serializer.data,status=status.HTTP_200_OK)
#
#     def patch(self,request):
#         try:
#             obj=CityBreak.objects.get(id=id)
#         except CityBreak.DoesNotExist:
#             msg={"msg":"not found"}
#             return Response(msg,status=status.HTTP_404_NOT_FOUND)
#         serializer = CityBreakSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#     def delete(self,request,id):
#         try:
#             obj=CityBreak.objects.get(id=id)
#         except CityBreak.DoesNotExist:
#             msg={"msg":"not found"}
#             return Response(msg,status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg":"deleted"},status=status.HTTP_204_NO_CONTENT)
# #
#
# class PersonList(generics.ListAPIView):
#     queryset=Person.objects.all()
#     serializer_class=PersonSerializer
#     def get(self, request):
#         obj = Person.objects.all()
#         serializer = PersonSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = PersonSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
# class PersonIds(generics.ListAPIView):
#     queryset = Person.objects.all()
#     serializer_class = PersonSerializerIds
#     def get(self,request):
#         obj=Person.objects.all()
#         serializer=PersonSerializerIds(obj,many=True)
#         return Response(serializer.data,status=status.HTTP_200_OK)
#
# class PersonDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset=Person.objects.all()
#     serializer_class=PersonSerializer
#     def get(self,request):
#         try:
#             obj = Person.objects.get(id=id)
#         except Person.DoesNotExist:
#             msg = {"msg": "not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#
#     def patch(self,request):
#         try:
#             obj=Person.objects.get(id=id)
#         except Person.DoesNotExist:
#             msg={"msg":"not found"}
#             return Response(msg,status=status.HTTP_404_NOT_FOUND)
#         serializer = PersonSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#     def delete(self,request,id):
#         try:
#             obj=Person.objects.get(id=id)
#         except Person.DoesNotExist:
#             msg={"msg":"not found"}
#             return Response(msg,status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg":"deleted"},status=status.HTTP_204_NO_CONTENT)
#
#
# class TravelAgencyList(generics.ListAPIView):
#     queryset = TravelAgency.objects.all()
#     serializer_class = TravelAgencySerializer
#
#     def get(self, request):
#         obj = TravelAgency.objects.all()
#         serializer = TravelAgencySerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = TravelAgencySerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
# class TravelAgencyIds(generics.ListAPIView):
#     queryset = TravelAgency.objects.all()
#     serializer_class = TravelAgencySerializerIds
#     def get(self,request):
#         obj=TravelAgency.objects.all()
#         serializer=TravelAgencySerializerIds(obj,many=True)
#         return Response(serializer.data,status=status.HTTP_200_OK)
#
# class TravelAgencyDetail(generics.RetrieveUpdateDestroyAPIView):
#     queryset = TravelAgency.objects.all()
#     serializer_class = TravelAgencySerializer
#     def get(self,request,id):
#         try:
#             obj = TravelAgency.objects.get(id=id)
#         except TravelAgency.DoesNotExist:
#             msg = {"msg": "not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#
#         serializer=TravelAgencySerializer(obj)
#         return Response(serializer.data,status=status.HTTP_200_OK)
#
#     def put(self, request, id):
#         try:
#             obj = TravelAgency.objects.get(id=id)
#         except TravelAgency.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = TravelAgencySerializer(obj, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def patch(self, request, id):
#         try:
#             obj = TravelAgency.objects.get(id=id)
#         except TravelAgency.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = TravelAgencySerializer(obj, data=request.data, partial=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#
#     def delete(self,request,id):
#         try:
#             obj=TravelAgency.objects.get(id=id)
#         except TravelAgency.DoesNotExist:
#             msg={"msg":"not found"}
#             return Response(msg,status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg":"deleted"},status=status.HTTP_204_NO_CONTENT)
#
# class CityBreakAgencyContract(APIView):
#     queryset = CityBreakAgency.objects.all()
#     serializer_class = CityBreakAgencySerializer
#     # def get_queryset(self):
#     #     #obj=CityBreak.objects.all().values_list('id',flat=True)
#     #     query = CityBreakPerson.objects.all().values()
#     #     print(query.query)
#     #     return query
#
#
#     def get(self, request):
#         #obj=CityBreak.objects.all().values_list('id',flat=True)
#         queryset = CityBreakAgency.objects.all()
#         serializer = CityBreakAgencySerializer(queryset, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#
#     def post(self, request):
#         serializer = CityBreakAgencySerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
# class CityBreaksWithPriceBiggerThanN(generics.ListAPIView):
#     def get(self,request,n):
#         price=CityBreak.objects.filter(price__gte=n).values()
#         serializer=CityBreakSerializer(price,many=True)
#         return Response(serializer.data,status=status.HTTP_200_OK)
#
# class TravelAgenciesWithMoreThan100Emplyees(generics.ListAPIView):
#     def get(self,request):
#         employees = TravelAgency.objects.filter(nrOfEmployees__gte=100).values()
#         serializer = TravelAgencySerializer(employees, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
# class TravelAgencyOrderedByAveragePriceOfCitybreak(generics.ListCreateAPIView):
#     serializer_class = TravelAgencySerializer
#
#     def get_queryset(self):
#         query=TravelAgency.objects\
#                 .annotate(avg_price=Avg('citybreakagency__cityBreak__price'))\
#             .order_by('avg_price')
#         print(query.query)
#         return query
#
# class CityBreaksByNumberOfOtherAgenciesContract(generics.ListCreateAPIView):
#     serializer_class = CityBreakSerializer
#     def get_queryset(selfself):
#         query=CityBreak.objects.annotate(
#             num_other_agencies=Count(
#                 TravelAgency.cityBreak.through.objects.filter(
#                     cityBreak_id=OuterRef('pk')
#                 ).exclude(
#                     agency_id=OuterRef('agency__id')
#                 ).values('agency_id').distinct(),
#                 distinct=True
#             )
#         ).order_by('-num_other_agencies')[:3]
#         print(query.query)
#         return query
#
# class AddCitybreaks(APIView):
#
#     def post(self, request, id):
#         city_break_data = request.data
#         msg = "CREATED"
#
#         print(request.data)
#         for cit in city_break_data:
#             cit['person'] = id
#             print(cit)
#             serializer = CityBreakSerializer(data=cit)
#             if serializer.is_valid():
#                 serializer.save()
#         return Response(msg, status=status.HTTP_201_CREATED)
#
#     # def post(self, request):
#         # person = Person.objects.get(id=id)
#         # citBreaks_data = request.data['cityBreaks']
#         # citBreaks = []
#         # for citBreak_data in citBreaks_data:
#         #     citybreak = CityBreak.objects.create(product=person, text=citBreak_data['text'])
#         #     citBreaks.append(citybreak)
#         # return Response({'citybreaks': citBreaks})
#
#
#     # def post(self,request, parent_id):
#     #     # Validate the input data
#     #     serializer = CityBreakSerializer(data=request.data)
#     #     serializer.is_valid(raise_exception=True)
#     #
#     #     # Create new child entities
#     #     children_data = serializer.validated_data['citybreak']
#     #     children = []
#     #     for child_data in children_data:
#     #         child_data['person_id'] = parent_id
#     #         child = CityBreak.objects.create(**child_data)
#     #         children.append(child)
#     #
#     #     # Return the response
#     #     serializer = CityBreakSerializer(children, many=True)
#     #     return Response(serializer.data)
#     #
#     #
#     # #
#     def get(self, request,id):
#         obj = CityBreak.objects.filter(id=id)
#         serializer = CityBreakSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#
#
#
#
#
