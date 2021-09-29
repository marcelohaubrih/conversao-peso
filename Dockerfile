# Imagem Oficial DOTNET
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source

# COPIA DE ARQUIVOS PARA COMPILAÇÃO
COPY *.sln .
COPY ConversaoPeso.Web/*.csproj ./ConversaoPeso.Web/
RUN dotnet restore

# COMPILANDO APP e COPIANDO PARA WORKDIR 
COPY ConversaoPeso.Web/. ./ConversaoPeso.Web/
WORKDIR /source/ConversaoPeso.Web
RUN dotnet publish -c release -o /app --no-restore

# IMAGEM FINAL
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]