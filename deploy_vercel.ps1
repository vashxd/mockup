# Script para fazer deploy no Vercel
# Execute este script antes de fazer o deploy

Write-Host "🚀 Iniciando build para Vercel..." -ForegroundColor Green

# Limpa builds anteriores
Write-Host "🧹 Limpando builds anteriores..." -ForegroundColor Yellow
if (Test-Path "build\web") {
    Remove-Item -Recurse -Force "build\web"
    Write-Host "✅ Build anterior removido" -ForegroundColor Green
}

# Faz o build para web
Write-Host "🔨 Fazendo build do Flutter Web..." -ForegroundColor Yellow
flutter build web --release --web-renderer html

# Verifica se o build foi bem-sucedido
if (Test-Path "build\web\index.html") {    Write-Host "✅ Build concluido com sucesso!" -ForegroundColor Green
    Write-Host "📁 Arquivos gerados em: build\web\" -ForegroundColor Cyan
    
    # Lista os arquivos gerados
    Write-Host "`n📋 Arquivos principais gerados:" -ForegroundColor Cyan
    Get-ChildItem "build\web\" | Select-Object Name, Length | Format-Table
    
    Write-Host "`n🎯 Proximos passos:" -ForegroundColor Magenta
    Write-Host "1. Faça commit das alterações no Git" -ForegroundColor White
    Write-Host "2. Conecte seu repositório ao Vercel" -ForegroundColor White
    Write-Host "3. O Vercel fará o deploy automaticamente!" -ForegroundColor White
} else {
    Write-Host "❌ Erro no build! Verifique os logs acima." -ForegroundColor Red
    exit 1
}Write-Host "`n🌐 Seu app estara disponivel em: https://seu-projeto.vercel.app" -ForegroundColor Green
