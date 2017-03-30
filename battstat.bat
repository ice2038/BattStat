@ECHO OFF 
:: Localize variables 
SETLOCAL 

:: Use WMI to retrieve battery status information 
FOR /F "tokens=1* delims==" %%A IN ('WMIC /NameSpace:"\\root\WMI" Path BatteryStatus Get Charging^,Critical^,Discharging /Format:list ^| FIND "=TRUE"') DO SET "BatteryStatus=Status=%%A"
FOR /F "tokens=* delims=" %%A IN ('WMIC /NameSpace:"\\root\WMI" Path BatteryStatus Get RemainingCapacity /Format:list ^| FIND "="') DO SET "RemainingCapacity=%%A"
FOR /F "tokens=* delims=" %%A IN ('WMIC /NameSpace:"\\root\WMI" Path BatteryFullChargedCapacity Get FullChargedCapacity /Format:list ^| FIND "="') DO SET "FullChargedCapacity=%%A"

:: Read server IP
FOR /F "tokens=* delims=" %%A IN ('ini /s Server /i url settings.ini') DO SET "Url=%%A"

:: Sending results 
REM curl "%Url%?%BatteryStatus%&%RemainingCapacity%&%FullChargedCapacity%"