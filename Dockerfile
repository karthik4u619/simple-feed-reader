FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /simple-feed-reader/SimpleFeedReader
# Copy csproj and restore as distinct layers
RUN dotnet restore

# Copy everything else and build
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SimpleFeedReader.dll "]
