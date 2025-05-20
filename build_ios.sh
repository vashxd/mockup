#!/bin/bash
# Script para compilar e executar o app no iOS

echo "==== Iniciando compilação para iOS ===="

# Atualizar dependências do Flutter
flutter pub get

# Limpar projeto iOS
cd ios
rm -rf Pods
rm -rf .symlinks
rm -rf Flutter/Flutter.framework
rm -rf Flutter/Flutter.podspec
cd ..

# Executar pod install
cd ios
pod install
cd ..

# Compilar para iOS
flutter build ios --release

echo "==== Compilação concluída ===="
echo "Agora você pode executar o app em um dispositivo iOS ou simulador com:"
echo "flutter run -d 'nome_do_dispositivo_ou_simulador'"
