-- ���м�(�����)
-- 2020. 10. 08.
-------
-- ���̺��� ������ ����
DROP TABLE traffic;
DROP SEQUENCE traffic_seq;

-- ���̺� �ۼ�
CREATE TABLE traffic(
    no NUMBER PRIMARY KEY, -- ��ȣ
    title VARCHAR2(200) UNIQUE, -- ����
    content VARCHAR2(2000) NOT NULL, -- ����
    writer VARCHAR2(30) NOT NULL, -- �ۼ���
    writeDate date, -- �ۼ���
    hit NUMBER DEFAULT 1, -- ��ȸ��
    pw VARCHAR2(50) Not Null -- ��й�ȣ
);

-- ������ ����
CREATE SEQUENCE traffic_seq;

-- ������ ����
INSERT INTO traffic(no, title, content, writer, pw) 
VALUES(traffic_seq.nextval, '��������', '��������', '������' ,'1234');

-- Ŀ��
COMMIT;