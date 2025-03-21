#!/bin/bash 

# Khởi động code-server ở chế độ nền
code-server --auth none --port 8080 --host 0.0.0.0 &

# Đợi 5 giây để đảm bảo code-server đã khởi động
sleep 5

# Khởi động ngrok với token được cung cấp và tạo tunnel đến cổng 8080
ngrok authtoken 2uOH2eOMZZ1t3uMKUvW0Q4EusoW_7q55DwZ9SxNR5NsnG2XB5
ngrok http 8080 &

# Đợi một chút để ngrok khởi động hoàn toàn
sleep 5

# Lấy public URL từ API local của ngrok
public_url=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
echo "Public URL của ngrok: $public_url"

# Tính thời gian còn lại trước khi chạy update.py
total_seconds=2592000  # 30 ngày = 2.592.000 giây

while [ $total_seconds -gt 0 ]; do
    hours=$((total_seconds / 3600))
    minutes=$(( (total_seconds % 3600) / 60 ))
    seconds=$((total_seconds % 60))
    printf "Thời gian còn lại: %02d giờ %02d phút %02d giây\n" $hours $minutes $seconds
    sleep 1
    total_seconds=$((total_seconds - 1))
done





