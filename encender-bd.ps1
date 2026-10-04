# encender-bd.ps1 - Inicia el motor PostgreSQL portable de ZLaLaLaZ
$ErrorActionPreference = "Stop"
$Raiz = $PSScriptRoot
$PgBin = Join-Path $Raiz "pgsql\bin"
$PgData = Join-Path $Raiz "pgsql\data"
$PgLog = Join-Path $Raiz "pgsql\logfile"
$PgCtl = Join-Path $PgBin "pg_ctl.exe"
$PgIsReady = Join-Path $PgBin "pg_isready.exe"
$PidFile = Join-Path $PgData "postmaster.pid"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  ZLaLaLaZ - Iniciando Base de Datos      " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Verificar si ya está en ejecución
if (Test-Path $PidFile) {
    $Lineas = Get-Content $PidFile
    if ($Lineas.Count -gt 0) {
        $PidExistente = $Lineas[0].Trim()
        $Proceso = Get-Process -Id $PidExistente -ErrorAction SilentlyContinue
        if ($Proceso) {
            Write-Host "[INFO] PostgreSQL ya está en ejecución (PID: $PidExistente)." -ForegroundColor Green
            & $PgIsReady -h 127.0.0.1 -p 5432 -U postgres
            exit 0
        } else {
            Write-Host "[AVISO] Se detectó un archivo PID previo no cerrado. Limpiando..." -ForegroundColor Yellow
            Remove-Item $PidFile -Force
        }
    }
}

# 2. Iniciar el servidor
Write-Host "[INICIO] Iniciando PostgreSQL portable en 127.0.0.1:5432..." -ForegroundColor Yellow
& $PgCtl -D $PgData -l $PgLog start

# 3. Esperar confirmación
Start-Sleep -Seconds 2
$Intentos = 0
$Listo = $false

while ($Intentos -lt 10) {
    & $PgIsReady -h 127.0.0.1 -p 5432 -U postgres 2>$null
    if ($LASTEXITCODE -eq 0) {
        $Listo = $true
        break
    }
    Start-Sleep -Seconds 1
    $Intentos++
}

if ($Listo) {
    Write-Host "[EXITO] Base de datos PostgreSQL iniciada y lista para conexiones en 127.0.0.1:5432." -ForegroundColor Green
} else {
    Write-Host "[ERROR] El servidor no respondió a tiempo. Revisa el registro en: $PgLog" -ForegroundColor Red
    exit 1
}
