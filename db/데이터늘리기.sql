-- board ���̺��� ������ ��ü�� �����ؼ� �ٽ� �ֱ�
insert into weekly(no, title, content, writer, pw)
(select weekly_seq.nextval, title, content, writer, pw
 from weekly);
commit;