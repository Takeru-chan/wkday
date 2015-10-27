param($n)
#-----------------------------------------------------------------------
$credit = @"
  wkday.ps1 ver.0.1  2015.10.27  (c)Takeru.

  Usage: wkday.ps1 n

  Description:
         The wkday utility counts calendar days and work days.
         If arguments are not specified, help is displayed.

         The week of day off is specified by the environment variable,
         as XCALWEEK.
         If you want to cancel the individual date, you may specify
         by the file, named as "weekday.lst".
         And you want to specify the individual holiday, you may specify
         by the file, named as "holiday.lst".

         Copyright (c) 2015 Takeru.
         Release under the MIT license
         http://opensource.org/licenses/MIT

"@
#-----------------------------------------------------------------------
if (-Not ($n)) {
  $credit
  return
}
function wkday($day) {
  $today = Get-Date
  $hol = 0
  $week = @("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
  $dayoff = [System.Environment]::GetEnvironmentVariable("XCALWEEK").Split(",")
  if (Test-Path workday.lst) {$workday = (Get-Content workday.lst) -as [String[]]}
  if (Test-Path holiday.lst) {$holiday = (Get-Content holiday.lst) -as [String[]]}
  :loop foreach ($n in 0..($day * 2)) {
    $chkstr = $today.AddDays($n).toString("yyyyMMdd")
    foreach ($dow in $dayoff) {
      if ($week[$dow] -eq $today.AddDays($n).DayofWeek) {
        $hol++
      }
    }
    foreach ($str in $workday) {
      if ($chkstr -eq $str) {$hol--}
    }
    foreach ($str in $holiday) {
      if ($chkstr -eq $str) {$hol++}
    }
    if ($day -eq ($n - $hol)) {
      break loop
    }
  }
  Write-Host "After $day days is" $today.AddDays($day).toString("yyyy/MM/dd(ddd)") "(calendar)"
  Write-Host "After $day days is" $today.AddDays($day + $hol).toString("yyyy/MM/dd(ddd)") "(work day)"
}
wkday $n
