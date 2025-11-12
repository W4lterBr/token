# Repositório de Licenças - ERP Cooperativa

Este repositório armazena as informações de licenciamento do ERP.

## Estrutura

- `license/status.json` - Arquivo principal com todas as licenças ativas

## Formato do status.json

```json
{
  "licenses": [
    {
      "token": "TOKEN-AQUI",
      "cliente": "Nome do Cliente",
      "status": 1,
      "emitido_em": "2025-01-01T00:00:00Z",
      "expira_em": "2026-12-31T23:59:59Z",
      "max_users": 50,
      "features": ["financeiro", "operacional", "nfse"]
    }
  ]
}
```

## Status

- 1: Autorizado
- 2: Pendente
- 3: Inadimplente
- 4: Sem conexão

## Uso

O ERP consulta este arquivo via GitHub Raw para validar a licença do cliente.
