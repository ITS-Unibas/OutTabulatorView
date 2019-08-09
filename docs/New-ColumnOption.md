# New-ColumnOption

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
New-ColumnOption [-ColumnName] <Object> [[-title] <Object>] [[-formatter] <Object>] [[-sorter] <Object>]
 [[-headerFilter] <Object>] [[-align] <Object>] [[-editor] <String>] [[-headerSort] <String>]
 [[-frozen] <String>] [[-width] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ColumnName
{{ Fill ColumnName Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -align
{{ Fill align Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: left, right, center

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -editor
{{ Fill editor Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: input, textarea, number, tick, star, progress, select

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -formatter
{{ Fill formatter Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: plaintext, textarea, html, money, image, link, tick, tickCross, color, star, progress, lookup, buttonTick, buttonCross, rownum, handle, lineFormatter

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -frozen
{{ Fill frozen Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: true, false

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -headerFilter
{{ Fill headerFilter Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: input, number, true, tick, select, textarea

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -headerSort
{{ Fill headerSort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: true, false

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sorter
{{ Fill sorter Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: string, number, alphanum, boolean, exists, date, time, datetime, array

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -title
{{ Fill title Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -width
{{ Fill width Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
