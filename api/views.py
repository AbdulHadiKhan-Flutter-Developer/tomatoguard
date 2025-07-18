from rest_framework import generics
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status


from rest_framework.parsers import MultiPartParser,FormParser
from .models import usersearchingdata,userprofile
from .serializer import userdataserializer,userprofileserializer

class getdata(generics.ListCreateAPIView):
    queryset = usersearchingdata.objects.all()
    serializer_class = userdataserializer
    parser_classes = [MultiPartParser,FormParser]


class Deletedata(generics.DestroyAPIView):
    queryset = usersearchingdata.objects.all()
    serializer_class = userdataserializer
    lookup_field = 'id'


class userprofileview(APIView):
    parser_classes = [MultiPartParser, FormParser]

    def get(self,request, uid = None):
       
        if not uid:
            return Response({'error': 'uid is required'}, status=400)

        try:
            profile = userprofile.objects.get(uid=uid)
            serializer = userprofileserializer(profile)
            return Response(serializer.data, status=200)
        except userprofile.DoesNotExist:
            return Response({'error': 'userprofile not found'}, status=404)

    def post(self, request):
        uid = request.data.get('uid')
        if not uid:
            return Response({'error': 'uid is required'}, status=400)

        try:
            profile = userprofile.objects.get(uid=uid)
            serializer = userprofileserializer(profile, data=request.data, partial=True)
        except userprofile.DoesNotExist:
            serializer = userprofileserializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=201)
        else:
            print(serializer.errors)  # helpful in development
            return Response(serializer.errors, status=400)
