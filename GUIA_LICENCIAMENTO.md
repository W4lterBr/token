# Guia de Configuração de Licenciamento

## Situação Atual

O ERP está tentando acessar um repositório de licenças que não existe:
- URL: `https://raw.githubusercontent.com/W4lterBr/token/main/license/status.json`
- Erro: HTTP 404 (arquivo não encontrado)

## Duas Soluções Disponíveis

### ✅ SOLUÇÃO 1: Modo de Desenvolvimento (APLICADA)

**Status: JÁ ESTÁ ATIVO!**

O código foi modificado para pular a verificação de licença durante o desenvolvimento:
- Variável `DEV_MODE_SKIP_LICENSE = True` adicionada
- O ERP agora inicia normalmente sem verificar licença
- Token usado: "EAT8-M8ES-BVMC-FEY2" (armazenado localmente)

**Para usar:**
Apenas execute o ERP normalmente. A verificação está desabilitada.

**IMPORTANTE:** Antes de compilar para produção:
1. Abra `ERP_Financeiro.py`
2. Encontre a linha `DEV_MODE_SKIP_LICENSE = True`
3. Altere para `DEV_MODE_SKIP_LICENSE = False`

---

### 🔧 SOLUÇÃO 2: Criar Repositório de Token (Para Produção)

**Quando usar:** Quando for distribuir o ERP para clientes.

**Passos:**

1. **Criar repositório no GitHub:**
   - Acesse: https://github.com/new
   - Nome: `token`
   - Descrição: `Sistema de licenciamento ERP`
   - Visibilidade: **Privado** (recomendado) ou Público
   - Clique em "Create repository"

2. **Fazer upload dos arquivos:**
   - Os arquivos estão em: `C:\Users\Nasci\Desktop\token_repo_temp\`
   - Execute: `push_to_github.bat`
   - Ou faça manualmente:
     ```batch
     cd C:\Users\Nasci\Desktop\token_repo_temp
     git init
     git add .
     git commit -m "Initial commit - License structure"
     git branch -M main
     git remote add origin https://github.com/W4lterBr/token.git
     git push -u origin main
     ```

3. **Verificar se funcionou:**
   - Acesse: https://raw.githubusercontent.com/W4lterBr/token/main/license/status.json
   - Você deve ver o JSON com as licenças

4. **Ativar verificação no código:**
   - Altere `DEV_MODE_SKIP_LICENSE = False`
   - O ERP consultará o GitHub a cada inicialização

---

## Estrutura do Repositório de Token

```
token/
├── README.md
└── license/
    └── status.json  ← Arquivo principal com licenças
```

**Conteúdo do status.json:**
```json
{
  "licenses": [
    {
      "token": "EAT8-M8ES-BVMC-FEY2",
      "cliente": "Cooperativa Exemplo",
      "status": 1,
      "emitido_em": "2025-01-01T00:00:00Z",
      "expira_em": "2026-12-31T23:59:59Z",
      "max_users": 50,
      "features": ["financeiro", "operacional", "nfse"]
    }
  ]
}
```

**Status possíveis:**
- `1`: Autorizado (verde)
- `2`: Pendente (amarelo)
- `3`: Inadimplente (vermelho - bloqueia)
- `4`: Sem conexão (usa cache)

---

## Como Adicionar Novos Clientes

1. Edite o arquivo `license/status.json` no repositório `token`
2. Adicione um novo objeto no array `licenses`:
   ```json
   {
     "token": "NOVO-TOKEN-AQUI",
     "cliente": "Nome do Cliente",
     "status": 1,
     "emitido_em": "2025-11-12T00:00:00Z",
     "expira_em": "2026-11-12T23:59:59Z",
     "max_users": 100,
     "features": ["financeiro", "operacional", "nfse"]
   }
   ```
3. Faça commit e push
4. O cliente poderá usar imediatamente

---

## Fluxo de Verificação

1. **ERP inicia** → Tenta baixar `status.json` do GitHub
2. **Sucesso** → Valida token, verifica status e expira_em
3. **Falha (404/timeout)** → Usa cache local se existir
4. **Sem cache** → Pede token ao usuário ou bloqueia

**Cache local:** `_license_cache/status.json` (atualizado a cada verificação online)

---

## Modo de Desenvolvimento vs Produção

| Aspecto | Desenvolvimento | Produção |
|---------|----------------|----------|
| `DEV_MODE_SKIP_LICENSE` | `True` | `False` |
| Verificação online | ❌ Desabilitada | ✅ A cada início |
| Bloqueio por expiração | ❌ Não | ✅ Sim |
| Usa para | Desenvolvimento | Clientes finais |

---

## Testando o Sistema

**Com verificação desabilitada (atual):**
```
[licenca] MODO DE DESENVOLVIMENTO: Verificação de licença desabilitada!
```

**Com verificação habilitada:**
```
[licenca] URL=https://raw.githubusercontent.com/W4lterBr/token/main/license/status.json token_esperado=EAT8-M8ES-BVMC-FEY2
[licenca] Licença válida! Status=Autorizado (origem: remote)
```

---

## Próximos Passos

1. ✅ Continue desenvolvendo com modo DEV ativo
2. ⏳ Quando for compilar para produção:
   - Crie o repositório `token` no GitHub
   - Execute `push_to_github.bat`
   - Altere `DEV_MODE_SKIP_LICENSE = False`
   - Compile com `build_all.bat`
3. ✅ Distribua o instalador com verificação ativa

---

## Suporte

Se encontrar problemas:
- Verifique se o repositório está público ou se tem permissões
- Teste a URL manualmente no navegador
- Veja os logs com `DEBUG_LICENSE = True`
