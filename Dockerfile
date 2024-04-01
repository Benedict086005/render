# Use the official Python image from Docker Hub
FROM python:3.11.4-slim-bullseye

# Set the working directory in the container
WORKDIR /myapp

# Set environment variables to prevent Python from writing pyc files and buffering output
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Update the package lists for system dependencies
RUN apt-get update

# Install any necessary system dependencies
# (if any are required for your application)

# Copy the requirements file into the container at /app/
COPY ./requirements.txt /myapp/

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app/
COPY . /myapp

# Install python-dotenv to manage environment variables
RUN pip install python-dotenv

# Set the entry point command to run Gunicorn and start the Django application
ENTRYPOINT ["gunicorn", "myapp.wsgi", "-b", "0.0.0.0:8000"]

