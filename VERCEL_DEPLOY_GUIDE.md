# 🚀 GUIA COMPLETO: Deploy Flutter Web no Vercel

## ✅ Build Realizado com Sucesso!

Seu projeto Flutter foi compilado para web com sucesso! Agora siga estes passos:

## 📋 **PASSO A PASSO VERCEL:**

### 1️⃣ **Criar conta no Vercel**
- Acesse: [vercel.com](https://vercel.com)
- Clique em "Sign Up" 
- Use sua conta GitHub/GitLab (recomendado)

### 2️⃣ **Preparar o repositório Git**
Execute os comandos abaixo para preparar seu código:

```bash
# Inicializar Git (se ainda não foi feito)
git init

# Adicionar todos os arquivos
git add .

# Fazer commit
git commit -m "Deploy inicial para Vercel"

# Conectar ao GitHub (substitua pelo seu repositório)
git remote add origin https://github.com/seu-usuario/escola-app.git
git push -u origin main
```

### 3️⃣ **Importar projeto no Vercel**
1. **No Vercel Dashboard:**
   - Clique em "New Project"
   - Selecione "Import Git Repository"
   - Escolha seu repositório "escola-app"

2. **Configurações importantes:**
   ```
   Framework Preset: Other
   Build Command: flutter build web --release
   Output Directory: build/web
   Install Command: flutter pub get
   Root Directory: ./
   ```

3. **Variáveis de ambiente (se necessário):**
   - Adicione em "Environment Variables"
   - Exemplo: NODE_VERSION = 18

### 4️⃣ **Deploy automático**
- Clique em "Deploy"
- Aguarde 2-3 minutos
- Seu app estará online!

## 🌐 **URLs Geradas:**
- **Production:** `https://escola-app.vercel.app`
- **Preview:** `https://escola-app-git-main-seu-usuario.vercel.app`

## 🔧 **Configurações Avançadas:**

### Redirecionamentos (vercel.json)
```json
{
  "version": 2,
  "name": "escola-app",
  "builds": [
    {
      "src": "build/web/**",
      "use": "@vercel/static"
    }
  ],
  "routes": [
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

### Build personalizado
```json
{
  "buildCommand": "flutter build web --release --dart-define=ENV=production"
}
```

## 📱 **Deploy via CLI (Alternativo):**
```bash
# Instalar Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel

# Deploy para produção
vercel --prod
```

## 🛠️ **Comandos úteis:**
- **Build local:** `flutter build web --release`
- **Testar local:** `flutter run -d chrome --web-port=3000`
- **Logs Vercel:** `vercel logs`
- **Domínio custom:** `vercel domains add meudominio.com`

## 🎯 **Próximos passos:**
1. ✅ Build concluído
2. 📁 Arquivos em `build/web/`
3. 🔄 Commit no Git
4. 🚀 Deploy no Vercel
5. 🌐 App online!

## 📞 **Suporte:**
- **Vercel Docs:** [vercel.com/docs](https://vercel.com/docs)
- **Flutter Web:** [docs.flutter.dev/platform-integration/web](https://docs.flutter.dev/platform-integration/web)

---
**Status:** ✅ Pronto para deploy  
**Build Time:** ~2.5s  
**Output:** build/web/index.html
