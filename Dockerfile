FROM codercom/code-server:latest

USER root

# Cài đặt Node.js từ NodeSource (sử dụng curl có sẵn trong base image)
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g ngrok && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Cài đặt pip và huggingface_hub mà không cần python3-pip
RUN curl -fsSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py --break-system-packages --no-cache-dir && \
    pip install --no-cache-dir huggingface_hub --break-system-packages && \
    rm get-pip.py

# Thiết lập thư mục làm việc và sao chép file
WORKDIR /home/coder/project
COPY start.sh .
RUN chmod +x start.sh

# Chạy start.sh
RUN ./start.sh 
