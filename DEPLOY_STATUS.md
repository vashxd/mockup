# ⚡ Scripts de Deploy Rápido

## 🚀 Deploy para Vercel (Automático)
```bash
# Fazer build + commit + push (deploy automático)
flutter build web --release
git add .
git commit -m "Deploy: $(Get-Date -Format 'dd/MM/yyyy HH:mm')"
git push origin main
```

## 🌐 URLs do Projeto:
- **Production:** https://mockup-vashxd.vercel.app
- **GitHub:** https://github.com/vashxd/mockup
- **Vercel Dashboard:** https://vercel.com/vashxd/mockup

## 📊 Monitoramento:
- **Build Time:** ~6ms (super rápido!)
- **Deploy Region:** Washington, D.C. (iad1)
- **Cache:** Ativo e funcionando

## 🔧 Comandos Úteis:
```bash
# Build local para teste
flutter run -d chrome

# Build para produção
flutter build web --release

# Verificar status do git
git status

# Ver logs do Vercel (via CLI)
vercel logs

# Atualizar configuração do Vercel
vercel --prod
```

## ✅ Status: ONLINE e FUNCIONANDO!
