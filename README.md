# shell_script_backup
Este script cria um backup do diretório /home do usuário e verififica se já há um backup criado nos ultimos 7 dias no mesmo diretório destino.

# MODO DE USO
1 - Após o download do repositório, faça a descompactação do arquivo e dé permissão de execução para o arquivo backup_home.sh
```go
$chmod +x backup_home.sh
```
2 - execute o arquivo com o comando: 
```go
$./backup_home.sh <usuário> <destino_do_arquivo_de_backup>
```
(digite os <parâmetros> sem o uso de "<>")
*o tempo para criação do backup irá depender do tamanho de seu diretório e a velocidade de sua unidade de armazenamento.
