#!/bin/bash

# Script otimizado para instalar Flutter e fazer build no Vercel
set -e

echo "🚀 Iniciando setup Flutter para Vercel..."

# Definir diretório do Flutter
FLUTTER_DIR="$PWD/flutter"

# Fix git ownership issues
git config --global --add safe.directory /vercel/path0/flutter 2>/dev/null || true
git config --global --add safe.directory "$FLUTTER_DIR" 2>/dev/null || true
git config --global --add safe.directory "$PWD" 2>/dev/null || true

# Verificar se estamos no diretório correto
echo "📁 Diretório atual: $PWD"
echo "📋 Arquivos no diretório:"
ls -la

# Verificar se pubspec.yaml existe
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Erro: pubspec.yaml não encontrado no diretório atual!"
    echo "📁 Conteúdo do diretório:"
    ls -la
    exit 1
fi

# Verificar se Flutter já está instalado
if [ -d "$FLUTTER_DIR" ] && [ -f "$FLUTTER_DIR/bin/flutter" ]; then
    echo "✅ Flutter já instalado!"
    export PATH="$FLUTTER_DIR/bin:$PATH"
    flutter --version
else
    echo "📥 Baixando Flutter..."
    
    # Usar versão mais recente e estável
    FLUTTER_VERSION="3.24.3"
    FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
    
    # Baixar com timeout e retry
    curl -fSL --connect-timeout 30 --max-time 300 --retry 3 \
         "$FLUTTER_URL" -o flutter.tar.xz
    
    echo "📦 Extraindo Flutter..."
    tar -xf flutter.tar.xz
    
    # Limpar arquivo temporário
    rm flutter.tar.xz
    
    # Fix git ownership issues for Flutter directory
    git config --global --add safe.directory "$FLUTTER_DIR" 2>/dev/null || true
    
    # Adicionar ao PATH
    export PATH="$FLUTTER_DIR/bin:$PATH"
    
    # Verificar instalação
    flutter --version
    echo "✅ Flutter instalado com sucesso!"
fi

# Configurar Flutter para web
echo "🌐 Configurando Flutter para web..."
flutter config --enable-web --no-analytics

# Instalar dependências
echo "📦 Instalando dependências do projeto..."
flutter pub get

# Fazer build para web com otimizações
echo "🔨 Fazendo build otimizado para web..."
flutter build web --release --web-renderer canvaskit --tree-shake-icons

# Verificar se build foi bem-sucedido
if [ -f "build/web/index.html" ]; then
    echo "✅ Build concluído com sucesso!"
    echo "📁 Arquivos gerados em build/web/"
    ls -la build/web/
else
    echo "❌ Erro: Build falhou!"
    exit 1
fi
