# Use an official Python runtime as a parent image
ARG VARIANT=bullseye
FROM --platform=amd64 mcr.microsoft.com/devcontainers/python:0-${VARIANT}

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py when the container launches
CMD ["python", "app.py"]