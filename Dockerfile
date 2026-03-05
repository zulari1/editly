FROM node:20-bookworm

# Full dependencies for Editly + headless-gl + FFmpeg on Railway (fixes Xvfb + gl null errors)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    xvfb \
    x11-utils \
    xauth \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libgbm1 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxtst6 \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libasound2 \
    libatspi2.0-0 \
    libxshmfence1 \
    libfontconfig1 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libcairo2 \
    fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Make entrypoint executable
RUN chmod +x entrypoint.sh

ENV DISPLAY=:99
EXPOSE 3000

CMD ["./entrypoint.sh"]
