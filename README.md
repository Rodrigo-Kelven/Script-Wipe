
# Script Wipe
![Bash Script](https://img.shields.io/badge/bash_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white) 
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)


Este projeto tem como objetivo mostrar e eficiência e facilidade em acabar com um sistema Linux.

Escrito em Bash, o Script percorre todas as pastas até chegar a pasta root / ao chegar no root, o script corrompe, acabanco e initilizando o sistema.

# Como executar.
- Crie e rode um container para executar os testes. 

        docker run -it --rm ubuntu bash

- Ao entrar no container, realize as atualizações.

        apt update && apt install -y coreutils findutils nano

- Crie um arquivo chamado wipe.sh e coloque o conteúdo do arquivo wipe.sh no container.

- Dê permissão ao arquivo wipe.sh.

        chmod +x wipe.sh

- Execte o arquivo wipe.sh

        ./wipe.sh


### Contribuições

Se você deseja contribuir para este projeto, fique à vontade para criar pull requests ou relatar issues. Melhorias como persistência de dados, maior segurança, e otimizações de desempenho são sempre bem-vindas.

## Autores
- [@Rodrigo_Kelven](https://github.com/Rodrigo-Kelven)
