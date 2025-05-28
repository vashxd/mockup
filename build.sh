#!/bin/bash

# Script para instalar Flutter e fazer build no Vercel
set -e

echo "🚀 Iniciando instalação do Flutter para Vercel..."

# Verificar se Flutter já está instalado
if command -v flutter &> /dev/null; then
    echo "✅ Flutter já instalado!"
    flutter --version
else
    echo "📥 Baixando e instalando Flutter..."
    
    # Baixar Flutter versão estável
    curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz -o flutter.tar.xz
    
    # Extrair Flutter
    tar -xf flutter.tar.xz
    
    # Adicionar ao PATH
    export PATH="$PWD/flutter/bin:$PATH"
    
    # Verificar instalação
    flutter --version
    echo "✅ Flutter instalado com sucesso!"
fi

# Instalar dependências
echo "📦 Instalando dependências..."
flutter pub get

# Fazer build para web
echo "🔨 Fazendo build para web..."
flutter build web --release

echo "✅ Build concluído com sucesso!"
