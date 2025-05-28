#!/usr/bin/env powershell

# 🚀 SCRIPT FINAL PARA DEPLOY VERCEL - Flutter Web
# Este script testa e prepara o projeto para deploy no Vercel

Write-Host "🎯 INICIANDO VERIFICAÇÃO E DEPLOY FLUTTER WEB" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# 1. Verificar dependências
Write-Host "`n1️⃣  Verificando dependências..." -ForegroundColor Yellow

# Verificar Flutter
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Flutter não encontrado!" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✅ Flutter encontrado" -ForegroundColor Green
}

# 2. Limpar e preparar projeto
Write-Host "`n2️⃣  Preparando projeto..." -ForegroundColor Yellow
flutter clean
flutter pub get

# 3. Fazer build de produção
Write-Host "`n3️⃣  Fazendo build de produção..." -ForegroundColor Yellow
$buildResult = flutter build web --release
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Erro no build!" -ForegroundColor Red
    exit 1
}

# 4. Verificar arquivos gerados
Write-Host "`n4️⃣  Verificando arquivos gerados..." -ForegroundColor Yellow
$requiredFiles = @(
    "build/web/index.html",
    "build/web/main.dart.js",
    "build/web/flutter_bootstrap.js",
    "build/web/manifest.json"
)

$allFilesExist = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "✅ $file" -ForegroundColor Green
    } else {
        Write-Host "❌ $file - AUSENTE!" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    Write-Host "`n❌ Alguns arquivos necessários não foram gerados!" -ForegroundColor Red
    exit 1
}

# 5. Testar build localmente (opcional)
Write-Host "`n5️⃣  Teste local disponível..." -ForegroundColor Yellow
Write-Host "Para testar localmente, execute:" -ForegroundColor Cyan
Write-Host "  cd build/web" -ForegroundColor White
Write-Host "  python -m http.server 8080" -ForegroundColor White
Write-Host "  # Então acesse: http://localhost:8080" -ForegroundColor White

# 6. Status final
Write-Host "`n6️⃣  STATUS FINAL" -ForegroundColor Yellow
Write-Host "✅ Projeto pronto para deploy no Vercel!" -ForegroundColor Green
Write-Host "`nCONFIGURAÇÕES DO VERCEL:" -ForegroundColor Cyan
Write-Host "  Framework Preset: Other" -ForegroundColor White
Write-Host "  Build Command: flutter build web --release" -ForegroundColor White
Write-Host "  Output Directory: build/web" -ForegroundColor White
Write-Host "  Install Command: flutter pub get" -ForegroundColor White

# 7. Instruções finais
Write-Host "`n🎯 PRÓXIMOS PASSOS:" -ForegroundColor Cyan
Write-Host "1. Faça commit das mudanças:" -ForegroundColor White
Write-Host "   git add ." -ForegroundColor Gray
Write-Host "   git commit -m 'Fix Vercel config'" -ForegroundColor Gray
Write-Host "   git push" -ForegroundColor Gray
Write-Host "`n2. No Vercel Dashboard:" -ForegroundColor White
Write-Host "   - Conecte seu repositório GitHub" -ForegroundColor Gray
Write-Host "   - Use as configurações mostradas acima" -ForegroundColor Gray
Write-Host "   - Faça o deploy" -ForegroundColor Gray

Write-Host "`n🚀 DEPLOY PRONTO!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
