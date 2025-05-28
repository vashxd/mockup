# 🚀 SOLUÇÃO FLUTTER + VERCEL - INSTALAÇÃO AUTOMÁTICA

## ❌ PROBLEMA IDENTIFICADO:
```
sh: line 1: flutter: command not found
Error: Command "flutter pub get" exited with 127
```

**Causa:** Vercel não tem Flutter instalado por padrão.

## ✅ SOLUÇÕES (3 OPÇÕES):

### 🎯 OPÇÃO 1: Script Personalizado (RECOMENDADO)

**Arquivos criados:**
- `build.sh` ✅ Script que instala Flutter automaticamente
- `vercel.json` ✅ Atualizado para usar o script

**Como funciona:**
1. Baixa Flutter Linux estável
2. Extrai e adiciona ao PATH
3. Executa `flutter pub get`
4. Executa `flutter build web --release`

### 🎯 OPÇÃO 2: Build Command Inline

Se a Opção 1 não funcionar, substitua `vercel.json` por:

```json
{
  "buildCommand": "curl -fsSL https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.3-stable.tar.xz | tar -xJ && export PATH=\"$PWD/flutter/bin:$PATH\" && flutter pub get && flutter build web --release",
  "outputDirectory": "build/web",
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

### 🎯 OPÇÃO 3: Deploy Estático

Se as outras opções falharem, faça build local e deploy como site estático:

```bash
# Local
flutter build web --release

# Commit arquivos de build/web
git add build/web
git commit -m "Add built files"
git push
```

Então no Vercel:
- **Framework:** Static
- **Output Directory:** `build/web`
- **Build Command:** (deixar vazio)

## 🔄 PRÓXIMOS PASSOS:

### 1. Commit e Push:
```bash
git add build.sh vercel.json
git commit -m "Add Flutter auto-install for Vercel"
git push
```

### 2. Redeploy no Vercel:
- Acesse seu projeto no Vercel
- Clique em "Redeploy"
- Aguarde o build (pode demorar mais na primeira vez)

### 3. Monitorar Logs:
- Acompanhe os logs no Vercel Dashboard
- Procure por: "✅ Flutter instalado com sucesso!"

## 🔍 TROUBLESHOOTING:

### Se der timeout:
- Flutter download pode demorar
- Vercel tem limite de 10min para build

### Se der erro de permissão:
- Script `build.sh` precisa ser executável
- `chmod +x build.sh` já está no `vercel.json`

### Se der erro de PATH:
- Use a Opção 2 (build command inline)

## 📊 STATUS ATUAL:
- ✅ Scripts criados
- ✅ vercel.json configurado
- ✅ Pronto para commit e deploy

**Próximo passo:** Commit e redeploy! 🚀
