# dotnet tool install --global dotnet-sonarscanner
dotnet sonarscanner begin /k:"demo:github-dotnet" /n:"GitHub project - .Net Core" \
    /d:"sonar.host.url=$SONAR_HOST_URL" /d:"sonar.login=$SONAR_TOKEN"
dotnet build dotnetcore-sample.sln
dotnet sonarscanner end /d:"sonar.login=${SONAR_TOKEN}" -Dsonar.qualitygate.wait=true
