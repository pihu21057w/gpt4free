FROM python:3.11-slim

# Install required system packages including Chrome dependencies and git
RUN apt-get update && apt-get install -y \
    wget unzip gnupg curl git \
    libglib2.0-0 libnss3 libgconf-2-4 libxi6 libxcursor1 \
    libxss1 libxtst6 libatk-bridge2.0-0 libxrandr2 libasound2 \
    libgtk-3-0 xvfb fonts-liberation libappindicator3-1 \
    libu2f-udev xdg-utils

# Install Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# Set working directory
WORKDIR /app

# Copy your project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set port environment variable
ENV PORT=7860

# Run g4f API
CMD ["sh", "-c", "python3 -m g4f.cli api --bind 0.0.0.0:7860"]
