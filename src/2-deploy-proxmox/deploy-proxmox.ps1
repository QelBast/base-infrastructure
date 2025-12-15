param (
    [string]$ConfigPath = ".\config.psd1"
)

$cfg = Import-PowerShellDataFile $ConfigPath

$vmDir  = Join-Path $cfg.VmPath $cfg.VmName
$vhdDst = Join-Path $vmDir "$($cfg.VmName).vhdx"

function Get-VMIPv4 {
    param(
        [string]$VmName,
        [int]$TimeoutSec = 120
    )

    $elapsed = 0
    while ($elapsed -lt $TimeoutSec) {
        $ips = Get-VMNetworkAdapter -VMName $VmName |
            Select-Object -ExpandProperty IPAddresses |
            Where-Object { $_ -match '^\d{1,3}(\.\d{1,3}){3}$' }

        if ($ips) {
            return $ips[0]
        }

        Start-Sleep -Seconds 5
        $elapsed += 5
    }

    throw "Failed to obtain IP for VM $VmName"
}

Write-Information "==> Preparing VM directory"
New-Item -ItemType Directory -Force -Path $vmDir | Out-Null

Write-Information "==> Copying golden VHDX"
Copy-Item -Path $cfg.GoldenVhdx -Destination $vhdDst -Force

Write-Information "==> Creating VM"
Remove-VM -Name $cfg.VmName -ErrorAction SilentlyContinue
New-VM `
    -Name $cfg.VmName `
    -Generation $cfg.Generation `
    -MemoryStartupBytes ($cfg.MemoryGB * 1GB) `
    -Path $vmDir `
    -VHDPath $vhdDst `
    -SwitchName $cfg.SwitchName

Write-Information "==> Setting CPU and Memory"
Set-VM `
    -Name $cfg.VmName `
    -ProcessorCount $cfg.CpuCount `
    -StaticMemory `
    -MemoryStartupBytes ($cfg.MemoryGB * 1GB)

Write-Information "==> Resizing disk"
Resize-VHD -Path $vhdDst -SizeBytes ($cfg.DiskGB * 1GB)

Write-Information "==> Enabling nested virtualization"
Set-VMProcessor `
    -VMName $cfg.VmName `
    -ExposeVirtualizationExtensions $true

Write-Information "==> Disabling Secure Boot"
Set-VMFirmware `
    -VMName $cfg.VmName `
    -EnableSecureBoot Off

Write-Information "==> Starting VM"
Start-VM -Name $cfg.VmName

Write-Information "==> Proxmox VM deployed successfully!"

Write-Information "==> Waiting for VM IP..."
$vmIp = Get-VMIPv4 -VmName $cfg.VmName

$uiUrl = "https://${vmIp}:8006"

Write-Information "==> Proxmox UI: ${uiUrl}"
Start-Process $uiUrl
