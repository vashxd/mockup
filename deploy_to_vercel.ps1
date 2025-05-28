# Script para Deploy Automático no Vercel
# Este script faz o build local e copia arquivos para a raiz

Write-Host "🚀 Iniciando deploy para Vercel..." -ForegroundColor Green
Write-Host ""

# Passo 1: Limpar arquivos antigos da raiz
Write-Host "🧹 Limpando arquivos antigos da raiz..." -ForegroundColor Yellow
$filesToRemove = @("index.html", "main.dart.js", "flutter.js", "flutter_bootstrap.js", "flutter_service_worker.js", "manifest.json", "version.json", "favicon.png", ".last_build_id")
foreach ($file in $filesToRemove) {
    if (Test-Path $file) {
        Remove-Item $file -Force
    }
}
if (Test-Path "canvaskit") {
    Remove-Item -Recurse -Force "canvaskit"
}

# Passo 2: Limpar build anterior
Write-Host "🧹 Limpando build anterior..." -ForegroundColor Yellow
if (Test-Path "build") {
    Remove-Item -Recurse -Force "build"
}

# Passo 3: Fazer build do Flutter
Write-Host "🔨 Fazendo build do Flutter Web..." -ForegroundColor Yellow
flutter build web --release

if (-not (Test-Path "build\web\index.html")) {
    Write-Host "❌ ERRO: Build falhou! Arquivo index.html não encontrado." -ForegroundColor Red
    exit 1
}

# Passo 4: Copiar arquivos para a raiz
Write-Host "📁 Copiando arquivos para a raiz..." -ForegroundColor Yellow
Copy-Item -Path "build\web\*" -Destination "." -Recurse -Force

# Passo 5: Verificar se os arquivos foram copiados
if (-not (Test-Path "index.html")) {
    Write-Host "❌ ERRO: Falha ao copiar arquivos!" -ForegroundColor Red
    exit 1
}

$indexSize = (Get-Item "index.html").Length
Write-Host "✅ Arquivos copiados! Tamanho do index.html: $indexSize bytes" -ForegroundColor Green

# Passo 6: Adicionar arquivos ao Git
Write-Host "📦 Adicionando arquivos ao Git..." -ForegroundColor Yellow
git add .

# Passo 7: Fazer commit
$commitMessage = "Deploy: Arquivos na raiz para Vercel $(Get-Date -Format 'dd/MM/yyyy HH:mm')"
Write-Host "💾 Fazendo commit: $commitMessage" -ForegroundColor Yellow
git commit -m "$commitMessage"

# Passo 8: Push para GitHub (trigger deploy no Vercel)
Write-Host "🚀 Enviando para GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host ""
Write-Host "✅ Deploy enviado com sucesso!" -ForegroundColor Green
Write-Host "🌐 Seu app estará disponível em: https://mockup-vashxd.vercel.app" -ForegroundColor Cyan
Write-Host "📊 Monitor no Vercel: https://vercel.com/vashxd/mockup" -ForegroundColor Cyan
Write-Host ""
Write-Host "⏱️  Aguarde 2-3 minutos para o deploy completar." -ForegroundColor Yellow
