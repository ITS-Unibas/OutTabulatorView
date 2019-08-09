Import-Module ..\OutTabulatorView.psd1 -Force

$Data = Get-Process | Select-Object Company, Name, Handles

$ColumnOptions = $(
    New-ColumnOption Company -HeaderFilter select
    New-ColumnOption Name -HeaderFilter input
    New-ColumnOption Handles -HeaderFilter input
)
$ExportFolder = 'C:\Temp\TabulatorView'
New-Item -Path C:\Temp\TabulatorView -ItemType Directory

$Data | Out-TabulatorView -ColumnOptions $ColumnOptions -Path $ExportFolder -UseOffline -Verbose
$Data | Out-TabulatorView -ColumnOptions $ColumnOptions -Verbose -Layout fitColumns -HeaderFilter

Out-TabulatorView -Data $Data -ColumnOptions $ColumnOptions -Layout fitData -Path $ExportFolder -Title 'My Processes' -Theme Site -Verbose
