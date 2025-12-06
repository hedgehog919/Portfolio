#!/bin/bash
# 檢查並停止佔用端口 40000 的進程

PORT=40000

echo "檢查端口 $PORT 的佔用情況..."

# 使用 lsof 查找進程
if command -v lsof > /dev/null 2>&1; then
    PIDS=$(lsof -ti :$PORT 2>/dev/null)
    if [ -n "$PIDS" ]; then
        echo "找到佔用端口 $PORT 的進程："
        lsof -i :$PORT
        echo ""
        echo "是否要停止這些進程？(y/n)"
        read -r answer
        if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
            echo "$PIDS" | xargs kill -9 2>/dev/null
            sleep 1
            echo "已停止佔用端口的進程"
        fi
    else
        echo "端口 $PORT 未被佔用"
    fi
else
    echo "未找到 lsof 命令，無法檢查端口"
fi

