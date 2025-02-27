@echo off
rem 切换到指定目录
cd /d C:\IdeaProjects\wiki-pic\wiki-pic

rem 检查目录切换是否成功
if %errorlevel% neq 0 (
    echo 无法切换到指定目录，请检查目录路径是否正确。
    exit /b 1
)

rem 添加所有更改的文件到暂存区
git add .

set COMMIT_MESSAGE="update"

rem 检查是否有文件被修改或添加
for /f "delims=" %%i in ('git status --porcelain') do set CHANGES=%%i
if "%CHANGES%"=="" (
    echo 没有文件被修改，无需提交。
    exit /b 0
)

rem 检查 COMMIT_MESSAGE 环境变量是否存在
if "%COMMIT_MESSAGE%"=="" (
    echo 未设置 COMMIT_MESSAGE 环境变量，无法进行提交。
    exit /b 1
)

rem 提交更改
git commit -m "%COMMIT_MESSAGE%"

rem 推送更改到远程仓库
git push origin main

rem 检查推送是否成功
if %errorlevel% equ 0 (
    echo 代码已成功推送到远程仓库。
) else (
    echo 推送代码到远程仓库时出错。
)

rem 暂停窗口，等待用户按键
pause