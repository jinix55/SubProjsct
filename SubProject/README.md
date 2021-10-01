### 로컬 셋팅시 DB 설정방법
로컬에서 DB셋팅시 Docker를 이용하여 구동이 가능합니다.

* DB1번
```
docker run --name postgres12 -t \
      -e POSTGRES_USER="dbuser" \
      -e POSTGRES_PASSWORD="qwer1234@" \
      -e POSTGRES_DB="ap" \
      -p 5432:5432 \
      -d postgres:12
```

* DB2번
```
docker run --name postgres12_2 -t \
      -e POSTGRES_USER="dbuser" \
      -e POSTGRES_PASSWORD="qwer1234@" \
      -e POSTGRES_DB="ap2" \
      -p 5433:5432 \
      -d postgres:12
```

위와 같이 명령실행 후에 서버를 기동하면 페이지가 정상 동작됩니다.
물론 위에 명령 실행 전에 PC에 Docker가 설치되어 있어야 합니다.

* 서브 프로젝트 초기 시작
```
- 개발툴

eclipse : https://www.eclipse.org/downloads/ 또는 STS4(https://spring.io/tools) 설치
Visual Studio Code : https://code.visualstudio.com/download
DBever Community : https://dbeaver.io/download/
Source Tree : https://www.sourcetreeapp.com/
MySQL Community Server 5.7 : https://downloads.mysql.com/archives/installer/
(2021-05-17 수정) MariaDB(ver 10.3) : https://downloads.mariadb.org/
Tomcat 8.5 : https://tomcat.apache.org/download-80.cgi
Java : jdk-8u241-windows-x64 설치

- 준비사항

java 환경 변수 설정(참고: https://prolite.tistory.com/975)
MySQL Community Server 설치 후 https://github.com/RTdataLab/DE_NCS/blob/main/NVoiceMiner/script/default.sql 쿼리 실행
MariaDB(ver 10.3) 설치 후 https://github.com/RTdataLab/DE_NCS/blob/main/NVoiceMiner/script/default_mariaDB.sql 쿼리 실행
eclipse 에서 help -> Eclipse Marketplace에서 STS4(spring Tools 4) 검색후 설치 (STS4 설치시 생략)
(2021-05-17 추가) script 폴더에 있는 lombok.jar 파일을 이클립스 또는 STS4에 이동 후 실행하여 설치
eclipse 상단 메뉴에서 windows -> Preferences -> General -> Workspace -> Text file encoding -> Other -> UTF-8 선택
eclipse 에서 project Explor -> 마우스2(이하 마우스2를 오른쪽버튼 클릭으로 정의) -> import -> maven -> Existing Maven Project 선택 후 git에서 받은 폴더 선택
project(NVoiceMiner) 선택 -> 마우스2 -> maven -> update project 선택 -> Force Update of Snapshots/Releases 체크 -> OK
project(NVoiceMiner) 선택 -> 마우스2 -> Run As -> maven install 선택
project(NVoiceMiner) 선택 -> 마우스2 -> Run As -> Spring Boot App 선택
정상적으로 스타팅 되면 개발 준비 완료(http://localhost:8080 접속)