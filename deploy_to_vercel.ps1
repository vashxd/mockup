# Script para Deploy Automático no Vercel
# Este script faz o build local e envia para o Vercel como site estático

Write-Host "🚀 Iniciando deploy para Vercel..." -ForegroundColor Green
Write-Host ""

# Passo 1: Limpar build anterior
Write-Host "🧹 Limpando build anterior..." -ForegroundColor Yellow
if (Test-Path "build") {
    Remove-Item -Recurse -Force "build"
    Write-Host "✅ Build anterior removido" -ForegroundColor Green
}

# Passo 2: Fazer build do Flutter
Write-Host "🔨 Fazendo build do Flutter Web..." -ForegroundColor Yellow
flutter build web --release

if (-not (Test-Path "build\web\index.html")) {
    Write-Host "❌ ERRO: Build falhou! Arquivo index.html não encontrado." -ForegroundColor Red
    exit 1
}

# Passo 3: Verificar tamanho do build
$indexSize = (Get-Item "build\web\index.html").Length
Write-Host "✅ Build concluído! Tamanho do index.html: $indexSize bytes" -ForegroundColor Green

# Passo 4: Adicionar arquivos ao Git
Write-Host "📦 Adicionando arquivos ao Git..." -ForegroundColor Yellow
git add .

# Passo 5: Fazer commit
$commitMessage = "Deploy: Build atualizado $(Get-Date -Format 'dd/MM/yyyy HH:mm')"
Write-Host "💾 Fazendo commit: $commitMessage" -ForegroundColor Yellow
git commit -m "$commitMessage"

# Passo 6: Push para GitHub (trigger deploy no Vercel)
Write-Host "🚀 Enviando para GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host ""
Write-Host "✅ Deploy enviado com sucesso!" -ForegroundColor Green
Write-Host "🌐 Seu app estará disponível em: https://mockup-vashxd.vercel.app" -ForegroundColor Cyan
Write-Host "📊 Monitor no Vercel: https://vercel.com/vashxd/mockup" -ForegroundColor Cyan
Write-Host ""
Write-Host "⏱️  Aguarde 2-3 minutos para o deploy completar." -ForegroundColor Yellow
