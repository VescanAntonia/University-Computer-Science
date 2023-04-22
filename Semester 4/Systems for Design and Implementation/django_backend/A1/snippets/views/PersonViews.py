from snippets.models.Person import Person
from django.db.models import Avg,Count,OuterRef

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from rest_framework import generics
from rest_framework.views import APIView
from snippets.serializers.PersonSerializers import PersonSerializer,PersonSerializerIds

class PersonList(generics.ListAPIView):
    queryset=Person.objects.all()
    serializer_class=PersonSerializer
    def get(self, request):
        obj = Person.objects.all()
        serializer = PersonSerializer(obj, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = PersonSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)

class PersonIds(generics.ListAPIView):
    queryset = Person.objects.all()
    serializer_class = PersonSerializerIds
    def get(self,request):
        obj=Person.objects.all()
        serializer=PersonSerializerIds(obj,many=True)
        return Response(serializer.data,status=status.HTTP_200_OK)

class PersonDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset=Person.objects.all()
    serializer_class=PersonSerializer
    # def get(self,request):
    #     try:
    #         obj = Person.objects.get(id=id)
    #     except Person.DoesNotExist:
    #         msg = {"msg": "not found"}
    #         return Response(msg, status=status.HTTP_404_NOT_FOUND)

    def get(self,request,id):
        try:
            obj = Person.objects.get(id=id)
        except Person.DoesNotExist:
            msg = {"msg": "not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)

        serializer=PersonSerializer(obj)
        return Response(serializer.data,status=status.HTTP_200_OK)


    def patch(self,request):
        try:
            obj=Person.objects.get(id=id)
        except Person.DoesNotExist:
            msg={"msg":"not found"}
            return Response(msg,status=status.HTTP_404_NOT_FOUND)
        serializer = PersonSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)

    def delete(self,request,id):
        try:
            obj=Person.objects.get(id=id)
        except Person.DoesNotExist:
            msg={"msg":"not found"}
            return Response(msg,status=status.HTTP_404_NOT_FOUND)
        obj.delete()
        return Response({"msg":"deleted"},status=status.HTTP_204_NO_CONTENT)