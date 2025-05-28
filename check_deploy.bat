@echo off
cls
echo.
echo ==========================================
echo    VERIFICADOR DE DEPLOY - ESCOLA APP
echo ==========================================
echo.

echo [1] Verificando status do Git...
git log -1 --oneline
echo.

echo [2] Verificando build local...
if exist "build\web\index.html" (
    echo ✅ Build local: OK
    for %%I in ("build\web\index.html") do echo    Tamanho: %%~zI bytes
) else (
    echo ❌ Build local: ERRO - arquivo nao encontrado
)
echo.

echo [3] Testando conectividade...
ping -n 1 vercel.com >nul 2>&1
if %errorlevel%==0 (
    echo ✅ Conexao com Vercel: OK
) else (
    echo ❌ Conexao com Vercel: ERRO
)
echo.

echo [4] URLs para verificar:
echo    🌐 App: https://mockup-vashxd.vercel.app
echo    📊 Dashboard: https://vercel.com/vashxd/mockup
echo    📁 GitHub: https://github.com/vashxd/mockup
echo.

echo [5] Comandos uteis:
echo    flutter run -d chrome          (testar local)
echo    git status                     (verificar mudancas)
echo    flutter build web --release    (rebuild)
echo.

echo ==========================================
echo Se o app ainda mostrar 404, aguarde mais
echo 2-3 minutos para o deploy completar.
echo ==========================================
echo.
pause
