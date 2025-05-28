# Escola App 🎓

Uma aplicação Flutter moderna para gestão escolar.

## 🚀 Deploy no Vercel

### Opção 1: Deploy Automático (Recomendado)
1. **Faça o build do projeto:**
   ```bash
   .\deploy_vercel.ps1
   ```

2. **Acesse [Vercel.com](https://vercel.com) e faça login**

3. **Importe seu repositório:**
   - Clique em "New Project"
   - Conecte seu GitHub/GitLab
   - Selecione este repositório

4. **Configure o projeto:**
   - Framework Preset: **Other**
   - Build Command: `flutter build web --release`
   - Output Directory: `build/web`
   - Install Command: `flutter pub get`

### Opção 2: Deploy via CLI
```bash
# Instalar Vercel CLI
npm i -g vercel

# Fazer login
vercel login

# Deploy
vercel --prod
```

## 🛠️ Comandos Úteis

- **Build para produção:** `flutter build web --release`
- **Rodar localmente:** `flutter run -d chrome`
- **Deploy Vercel:** `.\deploy_vercel.ps1`

## 🌐 Links
- **App Live:** [escola-app.vercel.app](https://escola-app.vercel.app)
- **Vercel Dashboard:** [vercel.com/dashboard](https://vercel.com/dashboard)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
