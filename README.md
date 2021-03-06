# Work day counter for PowerShell.
稼働日を数えるPowerShellスクリプトです。おまけで暦日も数えます。  

## Usage | 使い方
引数に正の整数を指定すると、指定日を起点に指定日数後の日付を表示します。
指定日を省略すると、今日を起点に計算します。
休日設定をすることで、指定稼働日数後の日付がわかります。  

wkday.ps1 n [yyyyMMdd]

環境変数XCALWEEKに指定した曜日を休日と判定し、稼働日計数対象から外します。  
日曜：0, 月曜：1, 火曜：2, ... 土曜：6
土日休みの例）XCALWEEK=0,6

休日指定曜日に対し個別にこれをキャンセルし、稼働日扱いにすることができます。
カレントディレクトリ中のworkday.lstファイルに指定された日付は、休日指定曜日であっても稼働日計数対象になります。  

また休日指定曜日以外の祝日はカレントディレクトリ中のholiday.lstファイルで日付指定することで、稼働日計数対象から外すことができます。  

workday.lst / holiday.lstともに日付指定は１行あたり１日づつyyyymmdd形式で記載します。  

```
(*'-') >> Get-Date

2015年10月28日 8:07:42


(*'-') >> [System.Environment]::GetEnvironmentVariable("XCALWEEK")
0,6
(*'-') >> Get-Content workday.lst
20151031
(*'-') >> Get-Content holiday.lst
20151103
(*'-') >> .\wkday.ps1 14 20151027
After 14 days is 2015/11/10(火) (calendar)
After 14 days is 2015/11/16(月) (work day)
```

10月27日の14日後は暦日で11月10日であるが、土日を挟んでいるためこれを稼働日から外している。
ただし10月31日を稼働日設定としているため、実際に稼働日計数対象外は11月の1日(日),3日(火),7日(土),8日(日),14日(土),15日(日)の6日間となり、14稼働日後は11月16日となった。  

## License
This script has released under the MIT license.  
[http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)
