# Base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose the port the Flask app will run on
EXPOSE 5000

# Set the environment variable for Flask
ENV FLASK_APP=library.py

# Run the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]