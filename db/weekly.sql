drop table weekly;
drop sequence weekly_seq

create table weekly(
 no number primary key,    --��ȣ
 title varchar2(300) not null,    --����
 content varchar2(2000) not null,   --����
 writer varchar2(30) not null,   --�ۼ���
 writeDate date default sysdate,   --�ۼ���
 hit number default 0,   --��ȸ��
 pw varchar2(50) not null   --��й�ȣ
);

create sequence weekly_seq;