$ErrorActionPreference = 'Stop'
$url = 'https://chromewebstore.google.com/detail/finetune/aodcklfljbgpfkkapbkggplcejggidgo?hl=en'
$page = (Invoke-WebRequest -Uri $url -TimeoutSec 30).Content
$counts = [regex]::Matches($page, '(?<count>[0-9][0-9,]*\+?)\s+users\s*</div>') |
    ForEach-Object { $_.Groups['count'].Value } |
    Select-Object -Unique
if (@($counts).Count -ne 1) {
    throw 'Could not identify a single public user count in the Chrome Web Store listing.'
}

$file = Join-Path $PSScriptRoot '../assets/finetune-users.json'
@{ count = [string]$counts } | ConvertTo-Json -Compress | Set-Content $file -Encoding utf8
