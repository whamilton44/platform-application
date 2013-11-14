echo OFF
set ENV=prod
if "%1" NEQ "" (
    set ENV=%1
)

php app/console-framework oro:entity-extend:clear --env %ENV% || goto :error
php app/console-framework doctrine:schema:drop --force --full-database --env %ENV% || goto :error
php app/console-framework doctrine:schema:create --env %ENV% || goto :error
php app/console-framework oro:entity-config:init --env %ENV% || goto :error
php app/console-framework oro:entity-extend:init --env %ENV% || goto :error
php app/console-framework oro:entity-extend:update-config --env %ENV% || goto :error
php app/console-framework doctrine:schema:update --env %ENV% --force || goto :error
php app/console-framework doctrine:fixture:load --append --no-debug --no-interaction --env %ENV% || goto :error
php app/console-framework doctrine:fixtures:load --fixtures=src/Oro/src/Oro/Bundle/TestFrameworkBundle/Fixtures/ --append --no-debug --no-interaction --env %ENV% || goto :error
php app/console-framework oro:navigation:init --env %ENV% || goto :error
php app/console-framework oro:search:create-index --env %ENV% || goto :error
php app/console-framework oro:localization:dump --env %ENV% || goto :error
php app/console-framework assets:install web --env %ENV% || goto :error
php app/console-framework assetic:dump --env %ENV% || goto :error
php app/console-framework oro:assetic:dump --env %ENV%|| goto :error
php app/console-framework oro:translation:dump --env %ENV% || goto :error
php app/console-framework oro:requirejs:build --env %ENV% || goto :error
goto :EOF

:error
echo Failed with error #%ERRORLEVEL%.
exit /b %ERRORLEVEL%

