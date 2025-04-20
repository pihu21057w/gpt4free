FROM python:3.11-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget unzip gnupg curl \
    libglib2.0-0 libnss3 libgconf-2-4 libxi6 libxcursor1 \
    libxss1 libxtst6 libatk-bridge2.0-0 libxrandr2 libasound2 \
    libgtk-3-0 xvfb fonts-liberation libappindicator3-1 \
    libu2f-udev xdg-utils

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# Set workdir
WORKDIR /app

# Copy project files
COPY . .

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Set default port
ENV PORT=8000

# Run gpt4free API
CMD ["sh", "-c", "python3 -m g4f.cli api --bind 0.0.0.0:$PORT"]
