# estado-bd.ps1 - Consulta el estado del motor PostgreSQL portable
$Raiz = $PSScriptRoot
$PgBin = Join-Path $Raiz "pgsql\bin"
$PgData = Join-Path $Raiz "pgsql\data"
$PgCtl = Join-Path $PgBin "pg_ctl.exe"
$PgIsReady = Join-Path $PgBin "pg_isready.exe"
$PidFile = Join-Path $PgData "postmaster.pid"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  ZLaLaLaZ - Estado de Base de Datos      " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

if (Test-Path $PidFile) {
    $Lineas = Get-Content $PidFile
    if ($Lineas.Count -gt 0) {
        $PidExistente = $Lineas[0].Trim()
        Write-Host "Archivo PID: $PidExistente" -ForegroundColor Gray
    }
}

& $PgCtl -D $PgData status
& $PgIsReady -h 127.0.0.1 -p 5432 -U postgres
