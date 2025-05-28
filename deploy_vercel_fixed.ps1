# Deploy Flutter Web para Vercel
Write-Host "🚀 Iniciando deploy Flutter Web para Vercel..." -ForegroundColor Green

# Verificar se vercel CLI está instalado
if (-not (Get-Command vercel -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Vercel CLI não encontrado. Instalando..." -ForegroundColor Yellow
    npm install -g vercel
}

# Limpar e rebuildar
Write-Host "🧹 Limpando projeto..." -ForegroundColor Yellow
flutter clean
flutter pub get

# Build para produção
Write-Host "🔨 Fazendo build para produção..." -ForegroundColor Yellow
flutter build web --release

# Verificar se build foi bem-sucedido
if (Test-Path "build/web/index.html") {
    Write-Host "✅ Build bem-sucedido!" -ForegroundColor Green
    
    # Deploy para Vercel
    Write-Host "🚀 Fazendo deploy para Vercel..." -ForegroundColor Green
    vercel --prod
    
    Write-Host "✅ Deploy concluído! Verifique a URL fornecida pelo Vercel." -ForegroundColor Green
} else {
    Write-Host "❌ Erro no build! Verifique os logs acima." -ForegroundColor Red
    exit 1
}
