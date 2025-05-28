# Script para fazer deploy no Vercel - Versao Simples
Write-Host "Iniciando build para Vercel..." -ForegroundColor Green

# Limpa builds anteriores
Write-Host "Limpando builds anteriores..." -ForegroundColor Yellow
if (Test-Path "build\web") {
    Remove-Item -Recurse -Force "build\web"
    Write-Host "Build anterior removido" -ForegroundColor Green
}

# Faz o build para web
Write-Host "Fazendo build do Flutter Web..." -ForegroundColor Yellow
flutter build web --release --web-renderer html

# Verifica se o build foi bem-sucedido
if (Test-Path "build\web\index.html") {
    Write-Host "Build concluido com sucesso!" -ForegroundColor Green
    Write-Host "Arquivos gerados em: build\web\" -ForegroundColor Cyan
    
    Write-Host "`nProximos passos:" -ForegroundColor Magenta
    Write-Host "1. Acesse vercel.com e faca login" -ForegroundColor White
    Write-Host "2. Conecte seu repositorio GitHub" -ForegroundColor White
    Write-Host "3. Configure o build no Vercel" -ForegroundColor White
    Write-Host "4. Seu app estara online!" -ForegroundColor White
    
    Write-Host "`nConfiguracao do Vercel:" -ForegroundColor Cyan
    Write-Host "Framework: Other" -ForegroundColor White
    Write-Host "Build Command: flutter build web --release" -ForegroundColor White
    Write-Host "Output Directory: build/web" -ForegroundColor White
    Write-Host "Install Command: flutter pub get" -ForegroundColor White
} else {
    Write-Host "Erro no build! Verifique os logs acima." -ForegroundColor Red
    exit 1
}
