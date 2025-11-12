@echo off
chcp 65001 >nul
echo ========================================
echo  Criando repositório de TOKEN no GitHub
echo ========================================
echo.

cd /d "%~dp0"

echo [1/5] Inicializando repositório git...
git init
if errorlevel 1 goto :erro

echo [2/5] Adicionando arquivos...
git add .
if errorlevel 1 goto :erro

echo [3/5] Fazendo commit inicial...
git commit -m "Initial commit - License structure"
if errorlevel 1 goto :erro

echo [4/5] Renomeando branch para main...
git branch -M main
if errorlevel 1 goto :erro

echo [5/5] Conectando ao GitHub...
echo.
echo IMPORTANTE: Você precisa criar um repositório chamado 'token' no GitHub primeiro!
echo Acesse: https://github.com/new
echo Nome do repositório: token
echo Descrição: Sistema de licenciamento ERP
echo Visibilidade: Privado (ou Público se preferir)
echo.
pause
echo.

git remote add origin https://github.com/W4lterBr/token.git
if errorlevel 1 (
    echo Tentando atualizar remote...
    git remote set-url origin https://github.com/W4lterBr/token.git
)

echo.
echo Fazendo push para o GitHub...
git push -u origin main
if errorlevel 1 goto :erro

echo.
echo ========================================
echo  ✓ Repositório criado com sucesso!
echo ========================================
echo.
echo O arquivo de licença está disponível em:
echo https://raw.githubusercontent.com/W4lterBr/token/main/license/status.json
echo.
echo Agora você pode executar o ERP novamente!
echo.
pause
exit /b 0

:erro
echo.
echo ========================================
echo  ✗ Erro ao criar repositório!
echo ========================================
echo.
pause
exit /b 1
