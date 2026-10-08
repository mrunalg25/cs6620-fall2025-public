# Lightweight official Python base image
FROM python:3.11-slim

# Don't write .pyc files, show logs immediately,
# and tell pygame there's no real audio device in the container
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    SDL_AUDIODRIVER=dummy

# Working directory inside the container
WORKDIR /app

# Install dependencies first so this layer is cached
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files
COPY . .

# The Flask app listens on port 5000
EXPOSE 5000

# Start the app (this also runs auto_load_data)
CMD ["python", "app.py"]
