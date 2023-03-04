# Use an official Python runtime as the base image
FROM python:3.11

ENV PYTHONUNBUFFERED=1

# Copy the poetry.lock file
COPY pyproject.toml poetry.lock ./

# Install dependencies
# RUN pip install pipenv && pipenv install --system
RUN apt-get update && apt-get install -y curl
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python

# Set the working directory
WORKDIR .

# Copy and install application dependencies
COPY . .
RUN poetry install

# Expose the port
EXPOSE 8000

# Run the command to start the server
CMD ["python", "manage.py", "runserver"]
