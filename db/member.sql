-- ���̺��� ������ ����
DROP TABLE member;
DROP TABLE member_auth;
DROP SEQUENCE member_seq;

-- ���̺� �ۼ�
CREATE TABLE member(
    no NUMBER UNIQUE, -- ȸ�� ��ȣ
    userid VARCHAR2(20) PRIMARY KEY, -- ���̵�
    userpw VARCHAR2(2000) NOT NULL, -- ��й�ȣ
    nickname VARCHAR2(30) NOT NULL, -- ����
    email VARCHAR2(90) NOT NULL, -- �̸���
    local1 VARCHAR2(100), -- ��ȣ����1
    local2 VARCHAR2(100), -- ��ȣ����2
    local3 VARCHAR2(100), -- ��ȣ����3
    condition NUMBER DEFAULT 1, -- ȸ�� ����
    join_date DATE DEFAULT sysdate -- ���� ��¥
);

CREATE TABLE member_auth(
    userid varchar2(20) NOT NULL REFERENCES member(userid),
    auth varchar2(50) NOT NULL
);

-- ������ ����
CREATE SEQUENCE member_seq;

-- Ŀ��
COMMIT;