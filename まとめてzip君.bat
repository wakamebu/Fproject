@echo off
REM ------------------------------------------------------------------------------
REM 圧縮したいファイル・フォルダをまとめて "update.zip" にするバッチ
REM (Windows 10 以降標準の Compress-Archive を利用)
REM ------------------------------------------------------------------------------

:: 圧縮元フォルダ
set SOURCE_DIR=D:\Fproject
:: 圧縮先フォルダ
set OUTPUT_DIR=D:\Fproject\Build
:: 出力する ZIP の名前
set ZIP_NAME=update.zip

:: 圧縮対象ファイル／フォルダの一覧
:: (フォルダ名やファイル名に空白がある場合は必ず "..." で囲む)
:: PowerShell の配列形式('A','B','C')にして渡します。
set FILE_LIST="'FEO project_Data','MonoBleedingEdge','Updater','FEO project.exe','UnityCrashHandler64.exe','UnityPlayer.dll'"

:: まず SOURCE_DIR に移動 (圧縮対象が相対パスで見つかるように)
cd /d "%SOURCE_DIR%"

:: 既に同名の update.zip があれば削除しておく
if exist "%OUTPUT_DIR%\%ZIP_NAME%" (
    del "%OUTPUT_DIR%\%ZIP_NAME%"
)

:: PowerShell の Compress-Archive で ZIP を作成
:: -Force は上書き用。削除済みなので無くてもOKだけどね
powershell -Command ^
  "Compress-Archive -Path %FILE_LIST% -DestinationPath '%OUTPUT_DIR%\%ZIP_NAME%' -Force"

echo -----------------------------------
echo Done! Created => %OUTPUT_DIR%\%ZIP_NAME%
echo -----------------------------------
pause
