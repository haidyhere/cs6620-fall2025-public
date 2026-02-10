# 1. Use an appropriate Python base image
FROM python:3.11-slim

# 2. Set working directory inside the container
WORKDIR /app

# 3. Install system dependencies needed by pygame and pydub
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-image-dev \
    libsdl2-ttf-dev \
    libportmidi-dev \
    libfreetype6-dev \
    libjpeg-dev \
    zlib1g-dev \
    ffmpeg \
  && rm -rf /var/lib/apt/lists/*

# 4. Copy dependency list and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy application source code
COPY . .

# 6. Expose Flask application port
EXPOSE 5000

# 7. Run the Flask application
CMD ["python", "app.py"]