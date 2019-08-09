# OutTabulatorView

## Description

Sending output to an interactive table in a browser

## Installing

The easiest way to get OutTabulatorView is using the [PSRepository UNIBAS](http://its-psrepository.its.unibas.ch/feeds/UNIBAS/).

``` PowerShell
PS> Register-PSRepository -Name 'UNIBAS' -SourceLocation 'http://its-psrepository.its.unibas.ch/nuget/UNIBAS/' -InstallationPolicy Trusted -PackageManagementProvider NuGet
```

### Installing the module

You can install it using:

``` PowerShell
PS> Install-Module -Name OutTabulatorView
```

### Updating the module

Once installed from the PSRepository, you can update it using:

``` PowerShell
PS> Update-Module -Name OutTabulatorView
```

### Removing the module

You can remove it using:

``` PowerShell
PS> Uninstall-Module -Name OutTabulatorView
```

## Examples

``` PowerShell
$Data = Get-Process | Select-Object Company, Name, Handles

$ColumnOptions = $(
    New-ColumnOption Company -HeaderFilter select
    New-ColumnOption Name -HeaderFilter input
    New-ColumnOption Handles -HeaderFilter input
)

$Data | Out-TabulatorView -ColumnOptions $ColumnOptions -Layout fitColumns -HeaderFilter
```

``` PowerShell
$Data = Get-Process | Select-Object Company, Name, Handles

$ColumnOptions = $(
    New-ColumnOption Company -HeaderFilter select
    New-ColumnOption Name -HeaderFilter input
    New-ColumnOption Handles -HeaderFilter input
)

Out-TabulatorView -Data $Data -ColumnOptions $ColumnOptions -Layout fitData -Path 'C:\Temp\TabulatorView' -Title 'My Processes' -Theme Site
```

## Release History

A detailed release history is contained in the [Change Log](CHANGELOG.md).
