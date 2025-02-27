FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /simple-feed-reader

# Copy everything else and build
RUN dotnet build SimpleFeedReader.sln

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SimpleFeedReader.dll "]
