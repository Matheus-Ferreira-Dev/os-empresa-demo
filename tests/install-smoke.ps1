$ErrorActionPreference = 'Stop'

$sandbox = Join-Path $env:TEMP ("os-empresa-install-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $sandbox | Out-Null

try {
    $installer = Join-Path (Split-Path -Parent $PSScriptRoot) 'instalar.ps1'
    if (-not (Test-Path -LiteralPath $installer)) {
        Write-Host 'RED: installer does not exist yet'
        exit 1
    }

    & $installer -Target $sandbox
    $required = @('AGENTS.md', 'CLAUDE.md', 'COMECE-AQUI.md', 'templates', 'sistema', '.claude\skills')
    $missing = @($required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $sandbox $_)) })
    if ($missing.Count -gt 0) {
        throw "Missing after install: $($missing -join ', ')"
    }

    $marker = Join-Path $sandbox 'clientes\nao-apagar.md'
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $marker) | Out-Null
    Set-Content -LiteralPath $marker -Value 'dados do amigo'
    & $installer -Target $sandbox | Out-Null
    if ((Get-Content -LiteralPath $marker -Raw) -ne "dados do amigo`r`n") {
        throw 'Installer overwrote existing client data'
    }

    Write-Host 'GREEN: installer is idempotent and preserves client data'
}
finally {
    if (Test-Path -LiteralPath $sandbox) {
        Remove-Item -LiteralPath $sandbox -Recurse -Force
    }
}
