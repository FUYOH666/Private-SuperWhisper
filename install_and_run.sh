#!/bin/bash

# SuperWhisper Simple - Установка и запуск
echo "🚀 SuperWhisper Simple - Установка и запуск"
echo "============================================"
echo "✅ Исправления: повторения в длинных аудио + улучшенная автовставка"

# Проверка macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Это приложение работает только на macOS"
    exit 1
fi

# Проверка Python 3.11
if ! python3.11 --version >/dev/null 2>&1; then
    echo "❌ Требуется Python 3.11"
    echo "Установите через Homebrew: brew install python@3.11"
    exit 1
fi

# Создание виртуального окружения
echo "📦 Создание виртуального окружения..."
if [ ! -d "venv" ]; then
    python3.11 -m venv venv
fi

# Активация окружения
source venv/bin/activate

# Обновление pip
echo "⬆️  Обновление pip..."
pip install --upgrade pip

# Установка зависимостей
echo "⬇️  Установка зависимостей..."
pip install -r requirements.txt

# Создание директорий для кэша
echo "📁 Создание директорий..."
mkdir -p cache/transcriptions
mkdir -p cache/vad
mkdir -p cache/punctuation
mkdir -p models

# Проверка компонентов
echo "🧪 Проверка компонентов..."
python test_basic.py
if [ $? -eq 0 ]; then
    echo "✅ Все компоненты работают"
else
    echo "⚠️  Есть проблемы с компонентами, но можно продолжить"
fi

# Тест автовставки
echo "📋 Тест автовставки..."
python test_auto_paste.py
if [ $? -eq 0 ]; then
    echo "✅ Автовставка работает"
else
    echo "⚠️  Проблемы с автовставкой - проверьте разрешения"
fi

# Инструкция по настройке доступа
echo ""
echo "🔐 ВАЖНО: Настройка разрешений доступа"
echo "========================================="
echo "1. Откройте: System Settings → Privacy & Security → Accessibility"
echo "2. Нажмите '+' и добавьте:"
echo "   • Python (/opt/homebrew/bin/python3.11)"
echo "   • Terminal (/Applications/Utilities/Terminal.app)"
echo "3. Поставьте галочки рядом с добавленными приложениями"
echo ""
echo "Открыть настройки сейчас? (y/n)"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility"
    echo "Нажмите Enter после настройки разрешений..."
    read -r
fi

# Запуск приложения
echo ""
echo "🎤 Запуск SuperWhisper Simple"
echo "============================="
echo "✅ Исправления в этой версии:"
echo "   • 🔄 Исправлены повторения в длинных аудио"
echo "   • 📋 Улучшена автовставка - работает везде"
echo "   • 🧠 Оптимизированы параметры Whisper"
echo "   • 🛠 Добавлен алгоритм удаления повторений"
echo ""
echo "⌨️  Управление:"
echo "   • Option + Space - запись/остановка"
echo "   • Иконка 🎤/🔴 в строке меню"
echo "   • Текст автоматически вставляется в курсор"
echo ""
echo "🛑 Для остановки: Ctrl+C"
echo ""

python superwhisper.py 