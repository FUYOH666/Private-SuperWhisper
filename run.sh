#!/bin/bash

# SuperWhisper Simple - Быстрый запуск
echo "🎤 SuperWhisper Simple - Запуск..."

# Проверяем что виртуальное окружение существует
if [ ! -d "venv" ]; then
    echo "❌ Виртуальное окружение не найдено!"
    echo "Сначала запустите: ./install_and_run.sh"
    exit 1
fi

# Активируем окружение и запускаем
source venv/bin/activate
python superwhisper.py 