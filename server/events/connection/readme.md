# admin
- 관리자 입장 시, 공유 데이터에 자신의 아이디와 소켓 아이디 할당함
- 공유 데이터의 관리자 수를 +1 (waitingQueue에 쓰이는 변수)
- 만약 waitingQueue에 유저가 기다리고 있다면 지금 입장한 관리자에 그 기다리고 있던 유저를 배정
- 이 때 배정한다의 의미는 "userToAdmin[각 유저의 ID]=현재 들어온 관리자의 ID" 로 배열의 인덱스와 값을 세팅하여 어떤 유저가 어떤 관리자에게 배정되어 있는지를 설정함

# user
- 유저 입장 시, 공유 데이터에 자신의 아이디와 소켓 아이디를 할당함
- 만약, 관리자가 아직 아무도 입장하지 않았다면, (공유 데이터의 변수인 adminNum==0 이라면) waitingQueue에 자신을 할당
- 또한 공유 데이터의 관리자 리스트에 자신의 아이디를 push 
    - 관리자 리스트는 예를 들어, 1번 관리자가 어떠한 유저와 커넥션을 맺고 있는지의 정보를 가짐
    - 관리자 리스트 = ( [key] 관리자 아이디, [value] 유저 ID 배열)
- 그리고, 관리자에게 자신의 유저 아이디를 송신함.
    - 자신과 연결을 맺은 관리자가 자신의 아이디를 알아야 플러터 앱에 그 아이디를 저장해 채팅방을 띄어 줄 수 있음

# disconnect
- 일단 연결을 끊은 사용자가 일반 유저인지, 관리자인지에 따라 액션이 달라지는데, 아래 참조
    ## 관리자
    - 일단 코드 수정해야 함
    - 일단 공유 데이터의 소켓 배열에서 관리자의 소켓을 지워버림
    - 공유 데이터의 adminNum-=1
    - 관리자 자신에게 배정된 유저들을 다른 관리자에게 재배정시킴
    - 관리자가 아무도 없다면, waitingQueue에 넣고 리턴
    ## 일반 사용자
    - userNum-=1
    - 유저가 나갔으니 자신에게 배정된 관리자도 없는 것이며, userToAdmin[유저의 id]=null
    - 해당 유저의 소켓도 null로 바꿈