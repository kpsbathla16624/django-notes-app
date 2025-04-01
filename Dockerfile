# Use official Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app/backend

# Copy requirements first for caching optimization
COPY requirements.txt /app/backend/

# Install system dependencies (including MySQL client)
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all files after installing dependencies
COPY . /app/backend/

# Expose the port Django will run on
EXPOSE 8000

# Default command to run the server
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
