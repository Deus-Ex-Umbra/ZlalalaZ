# apagar-bd.ps1 - Detiene el motor PostgreSQL portable de LaLaLa
$ErrorActionPreference = "Continue"
$Raiz = $PSScriptRoot
$PgBin = Join-Path $Raiz "pgsql\bin"
$PgData = Join-Path $Raiz "pgsql\data"
$PgCtl = Join-Path $PgBin "pg_ctl.exe"
$PidFile = Join-Path $PgData "postmaster.pid"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  LaLaLa - Apagando Base de Datos       " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Comprobar si está corriendo
if (!(Test-Path $PidFile)) {
    Write-Host "[INFO] PostgreSQL no está en ejecución (no existe postmaster.pid)." -ForegroundColor Yellow
    exit 0
}

# 2. Detener con pg_ctl
Write-Host "[DETENCION] Deteniendo PostgreSQL de forma segura (modo fast)..." -ForegroundColor Yellow
& $PgCtl -D $PgData stop -m fast

if ($LASTEXITCODE -eq 0) {
    Write-Host "[EXITO] Base de datos detenida correctamente." -ForegroundColor Green
} else {
    Write-Host "[AVISO] pg_ctl stop reportó código $LASTEXITCODE. Verificando procesos..." -ForegroundColor Yellow
    if (Test-Path $PidFile) {
        $Lineas = Get-Content $PidFile
        if ($Lineas.Count -gt 0) {
            $PidExistente = $Lineas[0].Trim()
            $Proceso = Get-Process -Id $PidExistente -ErrorAction SilentlyContinue
            if ($Proceso) {
                Write-Host "[FORZADO] Deteniendo proceso $PidExistente..." -ForegroundColor Yellow
                Stop-Process -Id $PidExistente -Force
            }
        }
        Remove-Item $PidFile -Force -ErrorAction SilentlyContinue
    }
    Write-Host "[OK] Base de datos apagada." -ForegroundColor Green
}
