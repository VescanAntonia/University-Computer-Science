from snippets.models.CityBreak import CityBreak
from django.db.models import Avg,Count,OuterRef

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from rest_framework import generics
from rest_framework.views import APIView
from snippets.serializers.CityBreakSerializers import CityBreakSerializer

class CityBreaksDetail(APIView):
    def get(self, request):
        #obj=CityBreak.objects.all().values_list('id',flat=True)
        obj = CityBreak.objects.all()
        serializer = CityBreakSerializer(obj, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = CityBreakSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)


class CityBreaksInfo(APIView):

    # def get(self,request):
    #     try:
    #         obj = CityBreak.objects.get(id=id)
    #     except CityBreak.DoesNotExist:
    #         msg = {"msg": "not found"}
    #         return Response(msg, status=status.HTTP_404_NOT_FOUND)
    #
    #     serializer=CityBreakSerializer(obj)
    #     return Response(serializer.data,status=status.HTTP_200_OK)

    def get(self,request,id):
        try:
            obj = CityBreak.objects.get(id=id)
        except CityBreak.DoesNotExist:
            msg = {"msg": "not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)

        serializer=CityBreakSerializer(obj)
        return Response(serializer.data,status=status.HTTP_200_OK)


    def patch(self,request):
        try:
            obj=CityBreak.objects.get(id=id)
        except CityBreak.DoesNotExist:
            msg={"msg":"not found"}
            return Response(msg,status=status.HTTP_404_NOT_FOUND)
        serializer = CityBreakSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)

    def delete(self,request,id):
        try:
            obj=CityBreak.objects.get(id=id)
        except CityBreak.DoesNotExist:
            msg={"msg":"not found"}
            return Response(msg,status=status.HTTP_404_NOT_FOUND)
        obj.delete()
        return Response({"msg":"deleted"},status=status.HTTP_204_NO_CONTENT)

class CityBreaksWithPriceBiggerThanN(generics.ListAPIView):
    queryset = CityBreak.objects.all()
    def get(self,request,n):
        price=CityBreak.objects.filter(price__gte=n).values()
        serializer=CityBreakSerializer(price,many=True)
        return Response(serializer.data,status=status.HTTP_200_OK)



class AddCitybreaks(APIView):

    def post(self, request, id):
        city_break_data = request.data
        msg = "CREATED"

        print(request.data)
        for cit in city_break_data:
            cit['person'] = id
            print(cit)
            serializer = CityBreakSerializer(data=cit)
            if serializer.is_valid():
                serializer.save()
        return Response(msg, status=status.HTTP_201_CREATED)

    def get(self, request,id):
        obj = CityBreak.objects.filter(id=id)
        serializer = CityBreakSerializer(obj, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)