function Out-TabulatorView
{
    [CmdletBinding(DefaultParameterSetName = 'UseOnline')]

    param
    (
        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        $ColumnOptions,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        $Height,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        [ValidateSet('fitColumns', 'fitData')]
        $Layout,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        [ValidateSet('Simple', 'Midnight', 'Modern', 'Site')]
        $Theme,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        [ValidateSet('local')]
        $Pagination,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        $PaginationSize,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        $GroupBy,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        [switch]
        $HeaderFilter,

        [Parameter(Mandatory = $false, ParameterSetName = 'UseOnline')]
        [Parameter(Mandatory = $true, ParameterSetName = 'UseOffline')]
        [ValidateScript(
            {Test-Path -Path $_ -PathType Container}
        )]
        [string]
        $Path,

        [Parameter(Mandatory = $true, ParameterSetName = 'UseOffline')]
        [switch]
        $UseOffline,

        [Parameter(ParameterSetName = 'UseOnline')]
        [Parameter(ParameterSetName = 'UseOffline')]
        [string]
        $Title = 'Out-TabulatorView',

        [Parameter(ValueFromPipeline)]
        $Data
    )

    Begin
    {
        $HtmlFileName = [IO.Path]::GetTempFileName() -replace "\.tmp", ".html"

        $Records = @()

        $params = @{ } + $PSBoundParameters
        $params.Remove("ColumnOptions")
        $params.Remove("Data")
        $params.Remove("Verbose")
        $params.Remove("Path")
        $params.Remove("UseOffline")
    }

    Process
    {
        $Records += @($Data)
    }

    End
    {
        $names = $records[0].psobject.properties.name
        $targetData = $records | ConvertTo-Json -Depth 2 -Compress

        if ($null -eq $records.Count -or $records.Count -eq 1)
        {
            $targetData = "[{0}]" -f $targetData
        }

        $tabulatorColumnOptions = @{ }
        $tabulatorColumnOptions.columns = @()

        foreach ($name in $names)
        {
            $targetColumn = @{field = $name}

            if ($columnOptions.$name)
            {
                $columnOptions.$name.getenumerator() | ForEach-Object {
                    $targetColumn.($_.key) = $_.value
                }
            }

            if (!$targetColumn.ContainsKey("title"))
            {
                $targetColumn.title = $name
            }

            if ($headerFilter)
            {
                $targetColumn.headerFilter = "input"
            }

            $tabulatorColumnOptions.columns += $targetColumn
        }

        foreach ($entity in $params.GetEnumerator())
        {
            $tabulatorColumnOptions.($entity.Key) = $entity.Value
        }

        foreach ($column in $tabulatorColumnOptions.columns)
        {
            if ($column.headerFilter -eq 'select')
            {
                $htArr = [ordered]@{ }
                $htArr.Add('', 'All')
                $records.$($column.field) | Sort-Object -Property { $_ } | Select-Object -Unique | ForEach-Object {
                    $htArr.Add($_, $_)
                }
                $column.Add('headerFilterParams', $htArr)
            }
        }
        
        [string]$tabulatorColumnOptions = $tabulatorColumnOptions | ConvertTo-Json -Depth 5

        $tabulatorColumnOptions = $tabulatorColumnOptions.Replace('"lineFormatter"', 'lineFormatter').Replace('"true"', 'true')

        $tabulatorColumnOptions = $tabulatorColumnOptions.Substring(0, $tabulatorColumnOptions.Length - 1)

        @"
<!doctype html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>$($Title)</title>
    $(
    if ($Path -and $UseOffline)
    {
        "<link href=`"css/tabulator.min.css`" rel=`"stylesheet`">"

        if ($Theme)
        {
            "<link href=`"css/tabulator_$($Theme.ToLower()).min.css`" rel=`"stylesheet`">"
        }
    }
    else
    {
        "<link href=`"https://cdnjs.cloudflare.com/ajax/libs/tabulator/4.3.0/css/tabulator.min.css`" rel=`"stylesheet`">"      

        if ($Theme)
        {
            "<link href=`"https://cdnjs.cloudflare.com/ajax/libs/tabulator/4.3.0/css/tabulator_$($Theme.ToLower()).min.css`" rel=`"stylesheet`">"
        }
        else
        {
            "<link href=`"https://cdnjs.cloudflare.com/ajax/libs/tabulator/4.3.0/css/semantic-ui/tabulator_semantic-ui.css`" rel=`"stylesheet`">"
        }
    }
    )
</head>
<body>

    $(
    if ($Path -and $UseOffline)
    {
        "<script type=`"text/javascript`" src=`"js/jquery-3.3.1.min.js`"></script>"
        "<script type=`"text/javascript`" src=`"js/jquery-ui.min.js`"></script>"
        "<script type=`"text/javascript`" src=`"js/tabulator.min.js`"></script>"
        "<script type=`"text/javascript`" src=`"js/jquery.sparkline.min.js`"></script>"
    }
    else
    {
        "<script type=`"text/javascript`" src=`"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js`"></script>"
        "<script type=`"text/javascript`" src=`"https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js`"></script>"
        "<script type=`"text/javascript`" src=`"https://cdnjs.cloudflare.com/ajax/libs/jquery-sparklines/2.1.2/jquery.sparkline.js`"></script>"
        "<script type=`"text/javascript`" src=`"https://cdnjs.cloudflare.com/ajax/libs/tabulator/4.3.0/js/tabulator.min.js`"></script>"
        #"<script type=`"text/javascript`" src=`"https://cdnjs.cloudflare.com/ajax/libs/tabulator/4.3.0/js/jquery_wrapper.min.js`"></script>"
    }
    )

<div id="example-table"></div>

<script type="text/javascript">
    var lineFormatter = function(cell, formatterParams){
            setTimeout(function(){ //give cell enough time to be added to the DOM before calling sparkline formatter
        	cell.getElement().sparkline(cell.getValue(), {width:"100%", type:"line", disableTooltips:true});
        }, 10);
    };

    var tabledata = $($targetData)

    var table = new Tabulator("#example-table",
        $($tabulatorColumnOptions)
    });

    table.setData(tabledata)

    `$("#example-table").css({"font-family": "Arial, Helvetica, sans-serif"});

</script>
</body>
</html>
"@ | Set-Content -Path $HtmlFileName -Encoding UTF8

        if ($Path)
        {
            $FilePath = Move-Item -Path $HtmlFileName -Destination "$Path\index.html" -Force -PassThru
            $HtmlFileName = $FilePath.FullName

            if ($UseOffline)
            {
                try
                {
                    Copy-Item @("$PSScriptRoot\js\", "$PSScriptRoot\css\") -Destination $Path -Recurse -Force -ErrorAction Stop
                    Write-Verbose "Copied assets to path: $Path"
                }
                catch
                {
                    $_.Exception.Message
                }
            }
        }
        else
        {
            Start-Process $HtmlFileName    
        }
        
        Write-Verbose "File path: $HtmlFileName"
    }
}

function New-ColumnOption
{
    param(
        [Parameter(Mandatory)]
        $ColumnName,
        $title,
        [ValidateSet('plaintext', 'textarea', 'html', 'money', 'image', 'link', 'tick', 'tickCross', 'color', 'star', 'progress', 'lookup', 'buttonTick', 'buttonCross', 'rownum', 'handle', 'lineFormatter')]
        $formatter,
        [ValidateSet('string', 'number', 'alphanum', 'boolean', 'exists', 'date', 'time', 'datetime', 'array')]
        $sorter,
        [ValidateSet('input', 'number', 'true', 'tick', 'select', 'textarea')]
        $headerFilter,
        [ValidateSet('left', 'right', 'center')]
        $align,
        [ValidateSet('input', 'textarea', 'number', 'tick', 'star', 'progress', 'select')]
        [string]$editor,
        [ValidateSet('true', 'false')]
        [string]$headerSort,
        [ValidateSet('true', 'false')]
        [string]$frozen,
        [int]$width
    )

    $cn = $PSBoundParameters.ColumnName
    $null = $PSBoundParameters.Remove("ColumnName")

    @{$cn = @{ } + $PSBoundParameters }
}

Set-Alias -Name otv -Value Out-TabulatorView
