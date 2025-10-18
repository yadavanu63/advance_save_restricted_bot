FROM python:3.11-slim

# Update & install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
        git \
        wget \
        curl \
        bash \
        ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -U pip wheel && \
    pip install --no-cache-dir -r requirements.txt

# Set working directory
WORKDIR /app

# Copy all source code
COPY . .

# Start Flask and your custom Python process together
CMD bash -c "flask run -h 0.0.0.0 -p 8000 & python3 -m ggn"


