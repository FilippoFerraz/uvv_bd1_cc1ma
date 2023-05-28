


-- comando para sair de qualquer banco de dados remanscente
DROP DATABASE IF EXISTS uvv;

-- comando para sair de qualquer usuario logado com o nome 'filippo'
DROP USER IF EXISTS filippo;

-- comando para criar usuario com acesso para criar banco de dados e role, e senha cujo é 'raiz' 
CREATE USER filippo WITH CREATEDB CREATEROLE PASSWORD 'raiz';

-- comando para cirar o banco de dados uvv
CREATE DATABASE uvv
WITH OWNER filippo 
 TEMPLATE template0
 ENCODING 'UTF8'
 LC_COLLATE 'pt_BR.UTF-8'
 LC_CTYPE 'pt_BR.UTF-8'
 ALLOW_CONNECTIONS true;

-- comando para garantir conexão do banco de dados uvv com o usuário filippo
\c 'dbname=uvv user=filippo password=raiz';

 -- comando para criar esquema lojas 
CREATE SCHEMA lojas AUTHORIZATION filippo;

-- comando para usar o esquema com o usuario filippo e para que ele seja o principal
ALTER USER filippo
SET SEARCH_PATH TO lojas, "$user", public;

-- comando para criar tabela clientes
CREATE TABLE clientes (
                cliente_id NUMERIC(38)  NOT NULL,
                email      VARCHAR(255) NOT NULL,
                nome       VARCHAR(255) NOT NULL,
                telefone1  VARCHAR(20),
                telefone2  VARCHAR(20),
                telefone3  VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id));

-- comando para adicionar comentarios na tabela clientes
COMMENT ON TABLE  clientes             IS 'tabela de atribuições dos clientes';
COMMENT ON COLUMN clientes.cliente_id  IS 'id de identificação de cada cliente';
COMMENT ON COLUMN clientes.email       IS 'email do cliente';
COMMENT ON COLUMN clientes.nome        IS 'nome do cliente';
COMMENT ON COLUMN clientes.telefone1   IS 'telefone de contato numero 1 do cliente';
COMMENT ON COLUMN clientes.telefone2   IS 'telefone de contato numero 2 do cliente';
COMMENT ON COLUMN clientes.telefone3   IS 'telefone de contato numero 3 do cliente';

-- comando para criar tabela produtos
CREATE TABLE produtos (
                produto_id                NUMERIC(38)   NOT NULL,
                nome                      VARCHAR(255)  NOT NULL,
                preco_unitario            NUMERIC(10,2),
                detalhes                  BYTEA,
                imagem                    BYTEA,
                imagem_mime_type          VARCHAR(512),
                imagem_arquivo            VARCHAR(512),
                imgaem_charset            VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id));

-- comando para adicionar comentarios na tabela produtos
COMMENT ON TABLE  produtos                           IS 'tabela de atribuições dos produtos';
COMMENT ON COLUMN produtos.produto_id                IS 'Id de identificação do produto ( primary key da tabela produtos )';
COMMENT ON COLUMN produtos.nome                      IS 'nome do produto';
COMMENT ON COLUMN produtos.preco_unitario            IS 'preço do produto';
COMMENT ON COLUMN produtos.detalhes                  IS 'detalhes de cada produto';
COMMENT ON COLUMN produtos.imagem                    IS 'imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type          IS 'Tipo de conteúdo de uma imagem associada a um produto';
COMMENT ON COLUMN produtos.imagem_arquivo            IS 'Arquivo digital que contém a imagem específica do produto';
COMMENT ON COLUMN produtos.imgaem_charset            IS 'Codificação de caracteres correta para o texto associado às imagens dos produtos';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Data da ultima atualização da imagem do produto';

-- comando para criar tabela lojas
CREATE TABLE lojas (
                loja_id                 NUMERIC(38)  NOT NULL,
                nome                    VARCHAR(255) NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id));

-- comando para adicionar comentarios na tabela lojas
COMMENT ON TABLE  lojas                         IS 'Tabela de atribuiçoes das lojas';
COMMENT ON COLUMN lojas.loja_id                 IS 'Id de identificacao de cada loja ( primary key da tabela lojas )';
COMMENT ON COLUMN lojas.nome                    IS 'nome real de cada loja';
COMMENT ON COLUMN lojas.endereco_web            IS 'endereço ( link ) online para a pagina virtual da loja';
COMMENT ON COLUMN lojas.endereco_fisico         IS 'Endereço real da loja';
COMMENT ON COLUMN lojas.latitude                IS 'Latitude em realação ao globo da loja';
COMMENT ON COLUMN lojas.longitude               IS 'Longitude em relacao ao globo da loja';
COMMENT ON COLUMN lojas.logo                    IS 'logo pertencente a loja';
COMMENT ON COLUMN lojas.logo_mime_type          IS 'Identificador do tipo de conteúdo usado na Internet da loja.';
COMMENT ON COLUMN lojas.logo_arquivo            IS 'Arquivo digital que contém o logotipo específico da loja';
COMMENT ON COLUMN lojas.logo_charset            IS 'Codificação de caracteres usada para exibir corretamente o texto em um site ou plataforma online da loja';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Data da ultima atualização do logo da loja';

-- comando para criar tabela envios 
CREATE TABLE envios (
                envio_id         NUMERIC(38)  NOT NULL,
                loja_id          NUMERIC(38)  NOT NULL,
                cliente_id       NUMERIC(38)  NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status           VARCHAR(15)  NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id));
               
 -- comando para adicionar comentarios na tabela envios              
COMMENT ON TABLE  envios                  IS 'tabela de atriuções dos envios';
COMMENT ON COLUMN envios.envio_id         IS 'id de identificação do envio';
COMMENT ON COLUMN envios.loja_id          IS 'id de identificação da loja que foi efetuado o envio';
COMMENT ON COLUMN envios.cliente_id       IS 'id de identificação do cliente que o envio foi efetuado';
COMMENT ON COLUMN envios.endereco_entrega IS 'endereço de entrega do envio';
COMMENT ON COLUMN envios.status           IS 'status do envio';

-- comando para criar tabela estoques 
CREATE TABLE estoques (
                estoque_id  NUMERIC(38) NOT NULL,
                loja_id     NUMERIC(38) NOT NULL,
                produto_id  NUMERIC(38) NOT NULL,
                quantidade  NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id));
               
 -- comando para adicionar comentarios na tabela estoques              
COMMENT ON TABLE  estoques            IS 'tabela de atriuições dos estoques';
COMMENT ON COLUMN estoques.estoque_id IS 'id de identificação do estoque';
COMMENT ON COLUMN estoques.loja_id    IS 'id de identificação do estoque referente a loja';
COMMENT ON COLUMN estoques.produto_id IS 'id de identificação do produto pertencente no estoque';
COMMENT ON COLUMN estoques.quantidade IS 'quantidade referente aos produtos do estoque';

-- comando para criar tabela pedidos
CREATE TABLE pedidos (
                pedido_id  NUMERIC(38) NOT NULL,
                data_hora  TIMESTAMP   NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status     VARCHAR(15) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id));

-- comando para adicionar comentarios na tabela                
COMMENT ON TABLE  pedidos            IS 'Tabela de atribuições dos pedidos';
COMMENT ON COLUMN pedidos.pedido_id  IS 'id de identificação do pedido';
COMMENT ON COLUMN pedidos.data_hora  IS 'Data e hora que ocorreu o pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'id do cliente que solicitou o pedido';
COMMENT ON COLUMN pedidos.status     IS 'status do pedido';
COMMENT ON COLUMN pedidos.loja_id    IS 'id da loja que foi efetuado o pedido';

-- comando para criar tabela pedidos itens
CREATE TABLE pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL,
                produto_id      NUMERIC(38)   NOT NULL,
                numero_da_linha NUMERIC(38)   NOT NULL,
                preco_unitario  NUMERIC(10,2) NOT NULL,
                quantidade      NUMERIC(38)   NOT NULL,
                envio_id        NUMERIC(38),  
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id));
 
 -- comando para adicionar comentarios na tabela               
COMMENT ON TABLE  pedidos_itens                 IS 'tabela de atriuções dos pedidos de itens';
COMMENT ON COLUMN pedidos_itens.pedido_id       IS 'id de identificação do pedido';
COMMENT ON COLUMN pedidos_itens.produto_id      IS 'id de identificação do produto';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Numero da linha do item referente ao pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario  IS 'preço do item';
COMMENT ON COLUMN pedidos_itens.quantidade      IS 'quantidades existentes de pedidos em relação aos itens';
COMMENT ON COLUMN pedidos_itens.envio_id        IS 'id de identificação do envio do item';

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- comando para criar relacionamentos referentes as pk e fk
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- restrição de checagem para garantir que o preço do produto sempre seja maior ou igual a 0
ALTER TABLE produtos ADD CONSTRAINT preco_prod_positivo CHECK ( preco_unitario >= 0 );

-- restrição de checagem para garantir que a quantidades de pedidos sempre seja maior ou igual a 0
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_positivo CHECK ( quantidade >= 0 );

-- restrição de checagem para garantir que a quantidade de produtos sempre seja maior ou igual a 0
ALTER TABLE estoques ADD CONSTRAINT prod_positivo CHECK ( quantidade >= 0);

-- restrição de checagem para garantir que o preço dos pedidos sempre seja maior ou igual a 0
ALTER TABLE pedidos_itens ADD CONSTRAINT preco_pedi_positivo CHECK ( preco_unitario >=0 );

-- restrição de checagem para garantir que os dados dos status sempre sejam inseridos corretamente
ALTER TABLE pedidos ADD CONSTRAINT pedidos_status CHECK ( status IN ( 'CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'   ));

-- restrição de checagem para garantir que os dados dos status de envio sempre sejam inseridos corretamente
ALTER TABLE envios ADD CONSTRAINT envios_status CHECK ( status IN (  'CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'    ));

-- restrição de checagem para garantir que pelo menos uma das colunas de endereço web ou físico estejam preenchidas
ALTER TABLE lojas ADD CONSTRAINT lojas_enderecos_web_fisico CHECK (( endereco_web IS NOT NULL ) OR ( endereco_fisico IS NOT NULL ));


























