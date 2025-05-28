@echo off
echo.
echo ==========================================
echo    ESCOLA APP - DEPLOY VERCEL
echo ==========================================
echo.

echo [1/4] Fazendo build do Flutter Web...
flutter build web --release
if %errorlevel% neq 0 (
    echo ERRO: Build falhou!
    pause
    exit /b 1
)

echo.
echo [2/4] Build concluido com sucesso!
echo      Arquivos gerados em: build\web\
echo.

echo [3/4] Preparando Git...
git add .
git status

echo.
echo [4/4] PROXIMO PASSO:
echo      1. Acesse: https://vercel.com
echo      2. Faca login com GitHub
echo      3. Import Git Repository
echo      4. Configure:
echo         - Framework: Other
echo         - Build Command: flutter build web --release
echo         - Output Directory: build/web
echo         - Install Command: flutter pub get
echo.

echo ==========================================
echo    DEPLOY PRONTO! Acesse vercel.com
echo ==========================================
echo.
pause
