@ECHO OFF &COLOR 0A
TITLE %~n0
mode con: cols=60 lines=18

:begin
cd /d "C:\software\Tor Browser\Browser\TorBrowser\Data\Tor"
cls
echo.
echo.
echo     ------------------------------------------------
echo       ��ѡ����Ҫ��Tor�ڵ����,�л�ʱTorrc��ȥ��ֻ����
echo       ÿ�����ҵ�IP���и����ص㣬�뿴�б�����˵����
echo     ------------------------------------------------
echo.
echo       1���ձ���youtube-dl������Ƶר�ã� 
echo       2���������¹������ô�������٣� 
echo       3����������¼��������ר�ã� 
echo       4���ֶ��༭torrc
echo       5���˳�
echo.
echo.
choice /c 12345 /m "���������֣�"

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
  echo �޸ĺ�Ľڵ���Ϣ���£�������Tor��Ч��
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
  echo �޸ĺ�Ľڵ���Ϣ���£�������Tor��Ч��
  for /f "tokens=1* delims=:" %%a in ('findstr /n .* "torrc" 2^>nul') do (
  if %%a equ 24 echo ExitNodes %%b
)
  timeout /t 3 >nul
  goto :begin
)

if "%errorlevel%"=="5" exit
cls
echo.
echo ѡ�����������ѡ��
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
echo �޸ĺ�Ľڵ���Ϣ���£�������Tor��Ч��
for /f "tokens=1* delims=:" %%a in ('findstr /n .* "torrc" 2^>nul') do (
if %%a equ 24 echo ExitNodes %%b
)
timeout /t 3 >nul
goto :begin
goto :eof
  