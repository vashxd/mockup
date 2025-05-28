# Test Flutter Web Build
Write-Host "Testando build Flutter Web..." -ForegroundColor Green

# Limpar cache e build anterior
flutter clean
flutter pub get

# Build para web
flutter build web --release

# Verificar se os arquivos foram gerados
if (Test-Path "build/web/index.html") {
    Write-Host "✅ Build bem-sucedido! Arquivos gerados em build/web/" -ForegroundColor Green
    
    # Listar arquivos principais
    Write-Host "`nArquivos principais gerados:" -ForegroundColor Yellow
    Get-ChildItem "build/web" -Name | Where-Object { $_ -match "\.(html|js|json)$" }
    
    # Testar servidor local na pasta build
    Write-Host "`nIniciando servidor local para testar build..." -ForegroundColor Green
    Set-Location "build/web"
    python -m http.server 8080
} else {
    Write-Host "❌ Erro no build! Verificar logs acima." -ForegroundColor Red
}
