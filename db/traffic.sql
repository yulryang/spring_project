-- ���м�(�����)
-- 2020. 10. 08.
-------
-- ���̺��� ������ ����
DROP TABLE accident;
DROP SEQUENCE accident_seq;

-- ���̺� �ۼ�
CREATE TABLE accident(
    no NUMBER PRIMARY KEY, -- ��ȣ
    title VARCHAR2(200) UNIQUE, -- ����
    content VARCHAR2(2000) NOT NULL, -- ����
    writer VARCHAR2(30) NOT NULL, -- �ۼ���
    writeDate date, -- �ۼ���
    hit NUMBER DEFAULT 1, -- ��ȸ��
    pw VARCHAR2(50) Not Null -- ��й�ȣ
);

-- ������ ����
CREATE SEQUENCE accident_seq;

-- ������ ����
INSERT INTO accident(no, title, content, writer, pw) 
VALUES(accident_seq.nextval, '����1�Դϴ�', '����1', '�����' ,'1234');

-- Ŀ��
COMMIT;