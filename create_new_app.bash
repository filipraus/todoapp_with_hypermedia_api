#!/bin/bash


# Prompt the user for the new app's name
read -p "Enter the new app's name: " app_name


# Change directory to src
cd src


# Start the new app
echo "Starting $app_name"
poetry run django-admin startapp $app_name


# Change directory to the $app_name
cd $app_name


# Set up templates, static and tests folder structure
echo "Setting up templates, static and tests folder structures..."
mkdir templates
mkdir tests
touch tests/__init__.py
touch tests/test_views.py
touch tests/test_models.py
mkdir static
mkdir static/scss
cd .. # Change directory to src
touch tests/test_$app_name.py


# Configure $app_name/urls.py
touch ./$app_name/urls.py
echo -e "from django.urls import path \n \n \nurlpatterns = [\n\n]" >> ./$app_name/urls.py


# Configure settings.py
sed -i "/'main',/a\ \ \ \ '$app_name'," ./config/settings.py
sed "/urlpatterns = \[/a \ \ \ \ path('$app_name/', include('$app_name.urls'))," -i ./config/urls.py