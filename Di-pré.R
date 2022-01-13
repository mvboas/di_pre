#Script para pegar dados da tabela DI-pré da b3
#Adaptado por: Marcelo Vilas Boas de Castro
#última atualização: 05/11/2020

#Definindo diretórios a serem utilizados
getwd()
setwd("C:\\Users\\User\\Documents")

#Carregando pacotes que serão utilizados
library(stringr)
library(rvest)
library(stats)

bovespa <- 'http://www2.bmf.com.br/pages/portal/bmfbovespa/lumis/lum-taxas-referenciais-bmf-ptBR.asp'
html <- read_html(bovespa) 

dados_bov <- html %>%
  html_nodes(xpath = '//*[@id="tb_principal1"]')%>% #aqui você já tem a tabela, daqui para baixo o código apenas padroniza a tabela que vem desestruturada
  html_text()%>%
  str_replace(",", ".") %>%
  str_replace_all('(\r|\n){1,}',';')


dados_bov=strsplit(dados_bov,';')[[1]][5:892]%>% #transforma a string em uma lista e elimina o cabeçalho da base
  matrix(ncol = 3, byrow = TRUE)%>%
  as.data.frame()%>%
  setNames(c("Dias Coriidos", "DI_pre_252", "DI_pre_360"))

head(dados_bov)