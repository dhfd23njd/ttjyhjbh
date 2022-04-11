@ECHO OFF &COLOR 0A
TITLE %~n0
mode con: cols=60 lines=18

:begin
cd /d "C:\software\Tor Browser\Browser\TorBrowser\Data\Tor"
cls
echo.
echo.
echo     ------------------------------------------------
echo       请选择需要的Tor节点国家,切换时Torrc会去掉只读，
echo       每个国家的IP都有各自特点，请看列表后面的说明。
echo     ------------------------------------------------
echo.
echo       1、日本（youtube-dl下载视频专用） 
echo       2、法国、德国、加拿大（提高网速） 
echo       3、美国（登录邮箱网盘专用） 
echo       4、手动编辑torrc
echo       5、退出
echo.
echo.
choice /c 12345 /m "请输入数字："

if "%errorlevel%"=="1" call :changeCountry {JP}

if "%errorlevel%"=="2"  (
  attrib -r "torrc"
  (for /f "tokens=1* delims=:" %%a in ('findstr /n .* "torrc" 2^>nul') do (
  if %%a equ 24 (echo ExitNodes {FR},{DE},{CA}) else echo,%%b
  ))>tmp
  del torrc >nul 2>nul
  move tmp torrc >nul 2>nul
  attrib +r "torrc"
  cls
  echo.
  echo 修改后的节点信息如下，请重启Tor生效：
  for /f "tokens=1* delims=:" %%a in ('findstr /n .* "torrc" 2^>nul') do (
  if %%a equ 24 echo ExitNodes %%b
)
  timeout /t 3 >nul
  goto :begin
)

if "%errorlevel%"=="3" call :changeCountry {US}

if "%errorlevel%"=="4"  (
  attrib -r "torrc" & notepad "torrc" & attrib +r "torrc"
  cls
  echo.
  echo 修改后的节点信息如下，请重启Tor生效：
  for /f "tokens=1* delims=:" %%a in ('findstr /n .* "torrc" 2^>nul') do (
  if %%a equ 24 echo ExitNodes %%b
)
  timeout /t 3 >nul
  goto :begin
)

if "%errorlevel%"=="5" exit
cls
echo.
echo 选择错误，请重新选择！
timeout /t 3 >nul
goto :begin

:changeCountry
attrib -r "torrc"
(for /f "tokens=1* delims=:" %%a in ('findstr /n .* "torrc" 2^>nul') do (
  if %%a equ 24 (echo ExitNodes %1) else echo,%%b
))>tmp
del torrc >nul 2>nul
move tmp torrc >nul 2>nul
attrib +r "torrc"
cls
echo.
echo 修改后的节点信息如下，请重启Tor生效：
for /f "tokens=1* delims=:" %%a in ('findstr /n .* "torrc" 2^>nul') do (
if %%a equ 24 echo ExitNodes %%b
)
timeout /t 3 >nul
goto :begin
goto :eof
  