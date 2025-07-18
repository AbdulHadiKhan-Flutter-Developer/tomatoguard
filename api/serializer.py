
from rest_framework import serializers
from .models import usersearchingdata , userprofile


class userdataserializer(serializers.ModelSerializer):
    class Meta:
        model = usersearchingdata
        fields = '__all__'

class userprofileserializer(serializers.ModelSerializer):
    class Meta:
        model =   userprofile
        fields = '__all__'     

