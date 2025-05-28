# VERIFICACAO FINAL FLUTTER WEB - VERCEL
Write-Host "Verificando status do projeto..." -ForegroundColor Green

# Verificar Flutter
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    Write-Host "✅ Flutter OK" -ForegroundColor Green
} else {
    Write-Host "❌ Flutter não encontrado" -ForegroundColor Red
    exit 1
}

# Verificar build
if (Test-Path "build/web/index.html") {
    Write-Host "✅ Build web existe" -ForegroundColor Green
} else {
    Write-Host "❌ Build web não encontrado" -ForegroundColor Red
    Write-Host "Execute: flutter build web --release" -ForegroundColor Yellow
    exit 1
}

# Verificar vercel.json
if (Test-Path "vercel.json") {
    Write-Host "✅ vercel.json existe" -ForegroundColor Green
} else {
    Write-Host "❌ vercel.json não encontrado" -ForegroundColor Red
    exit 1
}

Write-Host "`n🎯 CONFIGURAÇÕES VERCEL:" -ForegroundColor Cyan
Write-Host "Framework Preset: Other"
Write-Host "Build Command: flutter build web --release"
Write-Host "Output Directory: build/web" 
Write-Host "Install Command: flutter pub get"

Write-Host "`n✅ PROJETO PRONTO PARA VERCEL!" -ForegroundColor Green
