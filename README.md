# DD Music

이 프로젝트는 Java, Spring, Tomcat, MySQL, JSP를 기반으로 음원 차트를 크롤링하여 보여주고, 음원을 스트리밍할 수 있는 웹 사이트를 구현한 것입니다.


## 기능

- 음원 차트 크롤링: 매일 Top 100 음원 차트를 크롤링하여 날짜별로 확인할 수 있습니다.
- 음원 스트리밍: 실제 음원을 스트리밍할 수 있도록 웹 플레이어를 제공합니다.
- MP3 다운로드: 음원을 MP3 형식으로 다운로드할 수 있습니다.
- 웹 플레이어: 웹 플레이어에는 재생목록, 반복재생, 셔플 등 다양한 기능이 포함되어 있으며, 볼륨 조정 기능도 제공합니다. 또한, 볼륨 설정은 쿠키에 저장되어 다음 로그인 시에도 유지됩니다.
- 로그인: 사용자 인증을 위한 로그인 기능을 제공합니다. 비밀번호는 bcrypt를 사용하여 암호화하고, 아이디와 비밀번호를 찾는 기능도 구현되어 있습니다. 임시 비밀번호는 이메일로 전송됩니다. 또한, 세션과 쿠키를 이용하여 자동로그인 기능을 추가하였습니다.
- 관리자 페이지: 차트 정보 확인, 업데이트, 데이터베이스 추가, 회원 관리, 음원 정보 조회 및 수정 등을 할 수 있는 관리자 페이지를 제공합니다. 음원 파일 업로드도 가능합니다.
- 게시판: 기본적인 CRUD 기능이 있는 게시판을 구현하였으며, 조회수와 댓글 기능도 포함되어 있습니다.
- 가수별 재생목록: 가수별로 음원을 분류하여 재생목록을 만들 수 있습니다.


## ERD

![image](https://github.com/DodamKing/DDMusic/assets/87540282/0a1f17df-69c7-4bda-b6e8-86380aade34c)



## 사용자 화면

### Index Page

![image](https://github.com/DodamKing/DDMusic/assets/87540282/7617e392-32a4-43df-893b-2669ab8501c2)

### Log in Page

로그인 페이지에서 회원가입 유도

로그인 상태 유지 기능으로 자동 로그인 구현

![image](https://github.com/DodamKing/DDMusic/assets/87540282/0458cce0-b576-4ef4-a5b4-ff7cec7d2e85)


### Sign up Page

아이디 중복체크

정규식 유효성 검사

![image](https://github.com/DodamKing/DDMusic/assets/87540282/d8ad9892-c14f-4b59-b826-bd9be9952e39)


### 계정 찾기

![image](https://github.com/DodamKing/DDMusic/assets/87540282/2abbabb6-73db-4552-a599-ff525d0016b5)

### 비밀번호 찾기

비밀번호는 메일로 전송

메일 보내는 시간 동안 사용자가 알 수 있게 로딩 화면 구현

비밀번호는 임의로 생성

![image](https://github.com/DodamKing/DDMusic/assets/87540282/659735c7-1283-4c6b-ab6a-ac7c64d27b37)


### 계정 설정

![image](https://github.com/DodamKing/DDMusic/assets/87540282/181d6db2-dd1b-43e7-ac6b-047794dbf24c)

### 맵버십

맴버십 가입 하지 않으면 1분 미리듣기

로그인 시 맴버십 가입 날짜 확인, 한달이 지나고 미결제면 맴버십 초기화

![image](https://github.com/DodamKing/DDMusic/assets/87540282/66302326-1542-4f72-bd49-d2dc37653cfa)


## 관리자 화면

### 음원 정보 스크랩핑

음원 차트를 스크랩핑하여 DB에 저장

차트 업데이트는 스케줄러를 이용하여 자동으로 하도록 구현

관리자가 직접 스크랩핑하여 저장하도록 하는 버튼도 구현

![image](https://github.com/DodamKing/DDMusic/assets/87540282/dfa5a6db-4229-4c74-8b75-512d0da31feb)


### 회원 정보 관리

![image](https://github.com/DodamKing/DDMusic/assets/87540282/69bd47fd-34fc-4c97-b4b1-ae18c35da086)

### 음원 정보 관리

음원 정보 입력, 검색, 조회 및 수정

![image](https://github.com/DodamKing/DDMusic/assets/87540282/61cff081-1d87-4750-86c6-89d8f65f7bc6)


### 음원 파일 관리

실제 재생되는 mp3 파일 업로드

파일의 유무 확인

맞는 파일인지 재생으로 확인

업로드 할 파일 미리듣기

![image](https://github.com/DodamKing/DDMusic/assets/87540282/6d2b34c5-58cb-47ba-a455-3e6503b5f4a1)




## 서비스 화면

### Chart Page

1위 ~ 100위 까지 순위별로 확인

날짜별 차트 확인 가능

스트리밍 가능

![image](https://github.com/DodamKing/DDMusic/assets/87540282/4f601ccd-17d6-45cd-8366-cbd392313099)



### 이달의 노래

재생 횟수로 가장 많이 재생된 top10 보여줌

이 페이지에서도 바로 스트리밍 가능

![image](https://github.com/DodamKing/DDMusic/assets/87540282/31cf56f1-d9bb-4344-bae5-1f8171c48ca5)



### Artist Page

플레이 했던 음원 데이터를 기반으로 좋아할 만한 가수 추천

가수를 선택하면 해당 가수의 노래들이 들어 있는 플레이 리스트 보여줌

![image](https://github.com/DodamKing/DDMusic/assets/87540282/5086cb03-09d2-4d1d-96e2-3664eb2a0be5)



### Play List

개인별 재생목록 시스템 구현

![image](https://github.com/DodamKing/DDMusic/assets/87540282/3f7a4753-ea35-40d7-bcfc-108bb3ae9160)



### Play List 추가하기

새 플레이리스트 추가 버튼 눌렀을 때 화면

새로운 플레이리스트를 추가

새롱누 플레이리스트를 만들면서 곡 추가 가능

![image](https://github.com/DodamKing/DDMusic/assets/87540282/6355bacb-e82b-4e73-a3f8-f0a73195a451)



### 구매한 MP3
구매한 MP# 내역 확인

다운로드 가능

다운로드 주소 보이지 안헥 ajax로 구현

![image](https://github.com/DodamKing/DDMusic/assets/87540282/f77af189-d479-4bcd-b885-b718741a330d)



### #내돈내듣

사용자가 많이 들었던 음악을 순위별로 카운트와 함께 보여줌

![image](https://github.com/DodamKing/DDMusic/assets/87540282/086b0ef3-dc14-491b-9273-2be12a8d3a1d)



### 사용자 리뷰 (게시판)

게시판 기능 구현

분류 별로 보기 가능

검색 가능

댓글 구현

![image](https://github.com/DodamKing/DDMusic/assets/87540282/d81176b4-6420-4826-9387-8b5889573d6d)



### 커밍쑨 DDMusic

날짜별 업데이트 곡 확인

클릭해서 세부사항 확인 가능

![image](https://github.com/DodamKing/DDMusic/assets/87540282/276de702-649f-475e-ad03-566fe8a90e05)




## 웹플레이어

### 플레이어에 추가

개별 추가

![image](https://github.com/DodamKing/DDMusic/assets/87540282/1acf1172-21fe-4697-b5a3-84bdbdee6bc7)


선택 추가

![image](https://github.com/DodamKing/DDMusic/assets/87540282/70bf73f8-dc68-4c65-bc4c-42d5261e71b5)


### 플레이어 UI

좋아요, 가사보기, 더보기, 셔플, 이전곡, 다음곡, 반복재생, 한곡듣기, 재생바, 재생시간, 음량 전부 구현

![image](https://github.com/DodamKing/DDMusic/assets/87540282/2fd1b901-e19f-4e5e-b845-b946c938f7cf)

가사보기, 더보기 디테일

![image](https://github.com/DodamKing/DDMusic/assets/87540282/27ba077d-736a-43e4-ac07-28726add3675)




