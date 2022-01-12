# 개발 설정 가이드

- Description
	- 상품 등록 관리 솔루션 사이트
  
- 개발툴
	- eclipse : https://www.eclipse.org/downloads/ 또는 STS4(https://spring.io/tools) 설치
	- DBever Community : https://dbeaver.io/download/
	- Source Tree : https://www.sourcetreeapp.com/   
	- MariaDB(ver 10.3) : https://downloads.mariadb.org/
	- Java : jdk-8u241-windows-x64 설치

- 준비 사항
	- java 환경 변수 설정(참고: https://prolite.tistory.com/975)
	- MariaDB(ver 10.3) 설치 후 script 폴더에 default_mariaDB.sql 쿼리 실행
	- eclipse 에서 help -> Eclipse Marketplace에서 STS4(spring Tools 4) 검색후 설치 (STS4 설치시 생략)
	- script 폴더에 있는 lombok.jar 파일을 이클립스 또는 STS4에 이동 후 실행하여 설치
	- eclipse 상단 메뉴에서 windows -> Preferences -> General -> Workspace -> Text file encoding -> Other -> UTF-8 선택
	- eclipse 에서 project Explor -> 마우스2(이하 마우스2를 오른쪽버튼 클릭으로 정의) -> import -> maven -> Existing Maven Project 선택 후 git에서 받은 폴더 선택
	- project(NVoiceMiner) 선택 -> 우측 마우스 클릭 -> maven -> update project 선택 -> Force Update of Snapshots/Releases 체크 -> OK
	- project(NVoiceMiner) 선택 -> 우측 마우스 클릭 -> Run As -> maven install 선택
	- project(NVoiceMiner) 선택 -> 우측 마우스 클릭 -> Run As -> Spring Boot App 선택
	- 정상적으로 스타팅 되면 개발 준비 완료(http://localhost 접속)