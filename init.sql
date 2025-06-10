CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    bio VARCHAR(255),
    location VARCHAR(255),
    sns VARCHAR(255),
    mbti VARCHAR(10),
    job VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    profile_image_filename VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS user_tech_stacks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS project (
    project_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    processing VARCHAR(255),
    recruitment_field VARCHAR(255),
    people INT DEFAULT 0,
    meet_location VARCHAR(255),
    like_count INT DEFAULT 0,
    view_count INT DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS project_stack (
    project_stack_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    stack VARCHAR(255),
    project_id BIGINT,
    FOREIGN KEY (project_id) REFERENCES project(project_id)
);

CREATE TABLE IF NOT EXISTS project_like (
    like_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id BIGINT,
    user_id BIGINT,
    FOREIGN KEY (project_id) REFERENCES project(project_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS project_comment(
    comment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    project_id BIGINT,
    user_id BIGINT,
    FOREIGN KEY (project_id) REFERENCES project(project_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS team (
    team_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(255),
    team_image VARCHAR(255),
    team_color VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS team_member (
    member_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_name VARCHAR(255),
    owner BOOLEAN,
    team_role VARCHAR(255),
    team_id BIGINT,
    user_id BIGINT,
    FOREIGN KEY (team_id) REFERENCES team(team_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE IF NOT EXISTS team_calendar (
    cal_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cal_start TIMESTAMP,
    cal_end TIMESTAMP,
    content VARCHAR(255),
    team_id BIGINT,
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);


CREATE TABLE IF NOT EXISTS project_applicant (
     applicant_id BIGINT AUTO_INCREMENT PRIMARY KEY,
     accepted BOOLEAN DEFAULT FALSE,
     user_id BIGINT,
     project_id BIGINT,
     FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
     FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS notification (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    receiver_id BIGINT,
    message VARCHAR(255),
    is_read BOOLEAN DEFAULT FALSE,
    target_id BIGINT,
    type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE
);



INSERT INTO users (user_id, nickname, email, password, bio, location, sns, mbti, job)
VALUES
    (1, 'eunseo', 'eunseo@naver.com', '$2a$10$t9/b6NAzhtuKc.BibC3wzuRtUh/WK/0kx8xfEAqMvSZHq.wiPGMVq',
     '백엔드 개발자 지망생입니다. Spring Boot에 관심이 많아요.', '경상북도', 'https://github.com/devlover','INTP', '학생'),
    (2, 'bob', 'bob@naver.com', '$2a$10$.QiPgFUltC2cWZIfGliCk.vj0Zwtux8am00R21sAJrYIzIyFAU7By',
     '백엔드 개발자 지망생입니다. Spring Boot에 관심이 많아요.', '경상남도', 'https://github.com/devlover','ENFJ', '개발자'),
    (3, 'charlie', 'charlie@naver.com', '$2a$10$EweauHtFZh7umLbxS/Z9p.FuelbCXoZwiu6lVqobYnCKBiPHgoqAe',
     '백엔드 개발자 지망생입니다. Spring Boot에 관심이 많아요.', '강원도', 'https://github.com/devlover','ENTP','디자이너'),
-- 비밀번호 : eunseoPassword123!, bobPassword123!, charliePassword123!

    (4, 'codingFox', 'fox@naver.com', '$2y$04$8dwOw5xM2nJCSCc93oo2fuIde4cPJTnmFbW.Og3OVtF6Q8bALr5sS',
    '프론트엔드에 관심 많은 대학생입니다. React를 배우고 있어요.', '충청북도', 'https://github.com/codingFox', 'ISFJ', '학생'),
    (5, 'stackBear', 'bear@naver.com', '$2y$04$kh2xo1seyZiZBh.feOjBh.nNSTuQW1z33E/PVl5.GBZo9EMR9ozIu',
     '풀스택 도전 중인 취준생입니다. 다양한 프로젝트를 해보고 싶어요.', '충청남도', 'https://github.com/stackBear', 'ESTP', '취업준비생'),
    (6, 'dataPenguin', 'penguin@naver.com', '$2y$04$p1Vh7Mg1JEhzEb5WwjfmvuFCf9F79MD5lTMhuh8hotM/yKc4q8gFa',
     '데이터 엔지니어링에 관심이 있어요. Python을 주로 사용합니다.', '전라북도', 'https://github.com/dataPenguin', 'INTJ', '개발자'),
-- 비밀번호 : foxPassword123!, bearPassword123!, penguinPassword123!
    (7, 'devCat', 'cat@naver.com', '$2y$04$RVdeFitsB8u/XOxaazqEdeBWwbJAwbX/Njm5AVbrLn43dCoJtMm3S',
    'Spring과 JPA 공부 중인 백엔드 개발자입니다. 고양이처럼 조용히 개발합니다.', '경기도', 'https://github.com/devCat', 'ESTP', '개발자'),
    (8, 'nightOwl', 'owl@naver.com', '$2y$04$mSjZ2r28yfBp6/Ru/P4nquWekGNPL/w/ct.oEM.HUcuP/GzY4eEgK',
     '밤에 집중이 잘 되는 올빼미형 개발자입니다. TypeScript 좋아해요.', '강원도', 'https://github.com/nightOwl', 'INTP', '학생'),
    (9, 'koalaDev', 'koala@naver.com', '$2y$04$N0yIgVOzNVIzkrZwlvMtw.SABPegbfcMDYbliqMR7Pv8.d7xi5Vs.',
     '편안한 개발을 추구하는 주니어 프론트엔드 개발자입니다.', '경상북도', 'https://github.com/koalaDev', 'ENFP', '프리랜서');
-- 비밀번호 : catPassword123!, owlPassword123!, koalaPassword123!




INSERT INTO user_tech_stacks (name, user_id)
VALUES
-- eunseo (user_id = 1)
('Spring', 1),
('Java', 1),
('MySQL', 1),
-- bob (user_id = 2)
('React', 2),
('JavaScript', 2),
('HTML', 2),
-- charlie (user_id = 3)
('Python', 3),
('Django', 3),
('Docker', 3),

-- codingFox (user_id = 4)
('React', 4),
('JavaScript', 4),
('CSS', 4),
-- stackBear (user_id = 5)
('JavaScript', 5),
('React', 5),
('Spring', 5),
-- dataPenguin (user_id = 6)
('Python', 6),
('BigData', 6),
('Docker', 6),
-- devCat (user_id = 7)
('Java', 7),
('Spring', 7),
('MySQL', 7),
-- nightOwl (user_id = 8)
('JavaScript', 8),
('React', 8),
('MySQL', 8),
-- koalaDev (user_id = 9)
('React', 9),
('JavaScript', 9),
('HTML', 9);



INSERT INTO team (team_id, team_name, team_image, team_color)
VALUES
    (1, 'AI 프로젝트 팀', 'hsl(182, 69%, 92%)', 'hsl(182, 69%, 92%)'),
    (2, '웹 개발 팀', 'hsl(205, 61%, 84%)', 'hsl(205, 61%, 84%)');

INSERT INTO team_member (member_id, member_name, owner, team_role, team_id, user_id)
VALUES
    (1, 'eunseo', true, '프론트', 1, 1),
    (3, 'bob', false, '프론트', 1, 2),
    (4, 'charlie', false, '백엔드', 1, 3),
    (2, 'eunseo', true, '프론트', 2, 1),
    (5, 'bob', false, '디자이너', 2, 2);

INSERT INTO team_calendar (cal_id, cal_start, cal_end, content, team_id)
VALUES
    (1, '2025-04-10 00:00:00', '2025-04-20 00:00:00', 'AI 모델 설계 회의', 1),
    (2, '2025-04-12 00:00:00', '2025-04-18 00:00:00', '데이터 수집 마감일', 1),
    (3, '2025-04-08 00:00:00', '2025-04-17 00:00:00', '웹 프론트 UI 회의', 2),
    (4, '2025-04-11 00:00:00', '2025-04-16 00:00:00', '백엔드 API 리뷰', 2);


INSERT INTO project (project_id, title, content, processing, recruitment_field, people, meet_location, like_count, view_count, created_at, user_id)
VALUES
(1, '모바일 개발자 모집 프로젝트 1',  '모바일 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '모집중', '모바일', 2, '경상북도', 0, 486, '2025-04-10 10:23:22', 2),
(2, '프론트 개발자 모집 프로젝트 2',  '프론트 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '수정중', '프론트', 4, '경상남도', 42, 458, '2025-04-20 10:23:22', 2),
(3, '인공지능 개발자 모집 프로젝트 3',  '인공지능 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '모집중', '인공지능', 5, '충청남도', 25, 283, '2025-05-01 10:23:22', 1),
(4, '백엔드 개발자 모집 프로젝트 4',  '백엔드 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '모집중', '백엔드', 3, '경상남도', 31, 292, '2025-04-09 10:23:22', 2),
(5, '백엔드 개발자 모집 프로젝트 5', '백엔드 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '수정중', '백엔드', 6, '충청북도', 28, 369, '2025-04-03 10:23:22', 1),
(6, '디자이너 개발자 모집 프로젝트 6',  '디자이너 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '수정중', '디자이너', 6, '전라남도', 12, 404, '2025-04-17 10:23:22', 3),
(7, '디자이너 개발자 모집 프로젝트 7', '디자이너 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '모집완료', '디자이너', 6, '충청북도', 4, 237, '2025-04-24 10:23:22', 2),
(8, '디자이너 개발자 모집 프로젝트 8','디자이너 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '모집완료', '디자이너', 5, '경상남도', 33, 132, '2025-04-13 10:23:22', 3),
(9, '모바일 개발자 모집 프로젝트 9', '모바일 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '수정중', '모바일', 4, '전라북도', 10, 172, '2025-04-16 10:23:22', 3),
(10, '프론트 개발자 모집 프로젝트 10','프론트 관련 기술을 활용한 실전 프로젝트를 함께 진행합니다.', '모집완료', '프론트', 6, '충청북도', 13, 282, '2025-04-13 10:23:22', 3),

(11, '사이드 프로젝트 프론트엔드 팀원 모집',
 '현재 React 기반으로 웹 서비스를 개발 중인 사이드 프로젝트 팀입니다.
 이번 프로젝트는 간단한 커뮤니티 기능을 가진 웹 플랫폼을 제작하는 것이 목표이며, 사용자 친화적인 UI/UX를 구현할 수 있는 프론트엔드 팀원을 찾고 있습니다.
 주요 기술 스택은 React, TypeScript, Styled-Components이며, GitHub를 활용한 협업과 기본적인 코드 리뷰 문화를 지향합니다.
 디자이너와 협업 경험이 있으시거나, 컴포넌트 단위 설계에 관심이 많으신 분이라면 더욱 좋습니다.
 주 2~3회 온라인 회의를 진행하고, 과제 방식으로 업무를 나누어 효율적으로 진행할 예정입니다.
 성장하고 싶은 분, 협업을 즐기는 분, 꾸준히 커밋할 수 있는 분을 기다립니다!',
 '모집중', '프론트', 3, '경기도', 10, 310, '2025-04-01 09:00:00', 4),

(12, '백엔드 API 개발 팀원 구인',
 '현재 간단한 일정 관리 웹 서비스를 개발 중이며, 백엔드 API 구현을 맡아주실 분을 찾고 있습니다.
 주요 스택은 Java + Spring Boot + JPA이며, 로그인/회원가입, 일정 CRUD, 알림 기능 등의 핵심 기능을 함께 설계하고 구현하게 됩니다.
 프로젝트는 실제 서비스 배포를 목표로 하며, Git, Jira, Notion 등을 통해 효율적인 협업 환경을 구성하고 있습니다.
 Swagger 기반 API 문서화 경험이 있으시거나, 테스트 코드 작성을 함께 할 수 있는 분이면 좋겠습니다.
 초보도 괜찮습니다. 다만 책임감 있게 꾸준히 참여하실 수 있는 분, 협업 커뮤니케이션을 중요하게 생각하시는 분을 선호합니다.
 주 1회 정기 회의와 상시 비동기 커뮤니케이션으로 운영합니다.',
 '모집중', '백엔드', 2, '충청남도', 8, 289, '2025-04-03 14:20:00', 7),

(13, '디자인 시스템 구축 프로젝트',
 '현재 웹 서비스 제작을 위해 디자인 시스템을 구축 중입니다.
 일관된 UI 컴포넌트를 만들기 위해 Atomic Design을 도입하고 있으며, 이를 기반으로 Figma에서 컴포넌트를 설계하고 문서화하고 있습니다.
 프론트엔드 개발자와의 소통이 활발한 팀으로, 디자이너의 의견이 적극적으로 반영되는 구조를 지향합니다.
 현재 Button, Input, Modal 등의 기초 컴포넌트부터 시작하여 점차 확장할 계획이며, UI 트렌드나 사용자 경험에 대한 인사이트가 있는 분을 환영합니다.
 디자인 시스템 구축 경험이 없더라도, 디자인 패턴과 협업에 관심 있는 디자이너라면 함께 하실 수 있습니다.
 정해진 회의 시간 외에는 비동기 커뮤니케이션 위주로 진행하므로, 유연한 참여도 가능합니다.',
 '모집중', '디자이너', 1, '강원도', 5, 170, '2025-04-04 16:45:00', 8),

(14, '모바일 앱 개발 실전 팀 구성',
 '저희 팀은 Flutter를 기반으로 실제 서비스 운영을 목표로 한 모바일 앱을 개발하고 있습니다.
 현재 간단한 SNS 기능과 위치 기반 서비스를 결합한 플랫폼을 기획 중이며, 앱 구조 설계와 UI 구축을 진행할 개발자분을 모집합니다.
 Firebase를 이용한 사용자 인증, 실시간 데이터 처리 등을 도입할 예정이며, GitHub을 통한 버전 관리와 코드 리뷰를 병행합니다.
 초보자도 환영하지만 일정 수준의 앱 개발 경험이나 학습 의지가 있으신 분을 선호합니다.
 기획자와 디자이너가 함께 참여하고 있으며, 기술적으로 성장할 수 있는 환경을 만들고자 합니다.
 주 2회 정기 회의 외에는 자유롭게 작업 가능하며, 적극적으로 의견 주실 수 있는 분이면 좋겠습니다.',
 '모집완료', '모바일', 4, '전라북도', 16, 442, '2025-04-05 11:10:00', 5),

(15, 'AI 추천 시스템 개발 팀원 모집',
 '사용자 맞춤형 콘텐츠 추천 시스템을 개발하고 있는 팀입니다.
 프로젝트에서는 Python과 scikit-learn, pandas 등의 도구를 사용해 사용자 데이터 기반의 추천 모델을 구현합니다.
 협업 툴로는 Git, Notion, Google Meet 등을 사용하며, 온라인 기반으로 유연하게 운영됩니다.
 알고리즘 기획부터 평가 지표 설계, 모델 개선까지 전 과정을 함께 해주실 수 있는 분을 찾고 있어요.
 추천 시스템이나 머신러닝 경험이 없더라도, 데이터 분석에 관심 있고 열정적으로 참여할 수 있다면 지원 가능합니다.
 실전 프로젝트를 통해 포트폴리오와 협업 경험을 쌓고 싶은 분에게 좋은 기회가 될 것입니다.',
 '모집중', '인공지능', 3, '충청북도', 12, 398, '2025-04-06 10:15:00', 6),

(16, 'Unity 기반 게임 제작 프로젝트',
 'Unity를 사용해 간단한 미니게임을 제작하고 있는 팀입니다.
 기획 단계는 마무리되었으며, 현재는 캐릭터 이동, 충돌 처리, UI 구성 등 주요 기능 개발에 집중하고 있습니다.
 프로젝트는 협업 중심으로 운영되며, Git과 Trello를 이용한 태스크 관리와 코드 공유를 진행합니다.
 2D/3D 중 관심 있는 영역에서 자유롭게 기여 가능하며, 포트폴리오용 결과물을 완성하는 것이 목표입니다.
 게임 개발 경험이 부족하더라도 Unity에 흥미가 있고 팀 프로젝트를 해보고 싶으신 분이라면 누구든지 환영합니다.
 현재 프론트/디자이너도 함께 참여하고 있어 다양한 의견 교환이 가능한 환경입니다.',
 '모집중', '게임', 5, '경상남도', 7, 215, '2025-04-07 17:30:00', 9),

(17, '프론트-디자인 협업 프로젝트',
 '안녕하세요! 웹 서비스 제작 중인 팀에서 디자이너 팀원을 모집합니다.
 현재 React를 기반으로 한 프론트엔드 개발이 진행 중이며, 디자인 시스템의 기획 및 UI 개선 작업을 함께 해주실 분을 찾고 있어요.
 디자인 툴은 Figma를 사용하고 있으며, 버튼, 입력창 등 공통 컴포넌트를 중심으로 한 UI 설계를 목표로 합니다.
 프론트엔드 개발자와 소통하며 실제 코드 반영에 영향을 주는 협업 경험을 쌓을 수 있습니다.
 개별 컴포넌트에 대한 문서화 경험, 스타일 가이드 제작 등에 관심 있는 분을 특히 환영합니다.
 정기 회의는 주 1~2회 정도 진행되며, 그 외에는 자유롭게 작업하실 수 있습니다.',
 '모집중', '디자이너', 2, '경상북도', 9, 122, '2025-04-08 13:00:00', 4),

(18, 'React Native 앱 개발자 모집',
 'React Native를 활용해 간단한 커뮤니티 기반 앱을 제작하는 프로젝트입니다.
 Expo를 사용하여 개발 초기 설정을 간소화했으며, Firebase를 통한 실시간 채팅 기능과 알림 기능을 구현할 예정입니다.
 협업 도구로는 GitHub, Notion, Discord를 사용하고 있으며, 유연하게 의견을 나누며 진행하고 있습니다.
 iOS/Android 환경에서 모두 작동 가능한 크로스 플랫폼 앱을 목표로 하고 있으며, 디자인 요소는 디자이너와 협력해 구축 중입니다.
 모바일 앱 개발에 관심 있는 분이라면 경험자든 초보자든 모두 환영합니다.
 함께 기획부터 배포까지 모든 과정을 경험할 수 있는 좋은 기회가 될 것입니다.',
 '모집완료', '모바일', 2, '충청남도', 11, 361, '2025-04-08 15:45:00', 5),

(19, 'AI 챗봇 개발 프로젝트',
 '저희는 현재 TensorFlow와 Transformers 기반의 AI 챗봇 시스템을 설계 중입니다.
 간단한 고객 응대 기능부터 시작해, 사용자의 질문 의도를 파악하고 적절한 답변을 제공하는 스마트 챗봇을 개발할 예정입니다.
 NLU(Natural Language Understanding)에 관심 있는 분이라면 더욱 좋습니다.
 현재 백엔드 및 프론트 개발자와 함께 작업 중이며, 자연어 처리에 집중하실 분을 찾고 있습니다.
 정해진 시간에 구애받지 않고 비동기로 자유롭게 진행되며, 발표용 데모도 준비할 예정입니다.
 AI 분야에 관심 있고 실전 프로젝트를 통해 실력을 쌓고 싶은 분은 편하게 지원해주세요.',
 '모집중', '인공지능', 3, '강원도', 15, 330, '2025-04-09 10:00:00', 6),

(20, '웹 미니게임 제작 프로젝트',
 'JavaScript와 HTML5 Canvas를 활용하여 미니 브라우저 게임을 제작하는 프로젝트입니다.
 플레이 타임이 짧은 캐주얼 게임을 목표로 하며, 예를 들어 클릭 게임, 미로 탈출, 피하기 게임 등을 구상 중입니다.
 게임 루프 구현, 점수 시스템, 애니메이션, 사운드 효과 등을 함께 고민하며 재미있는 결과물을 만들고자 합니다.
 CSS를 활용한 기본적인 UI 꾸미기, 모바일 대응 레이아웃도 함께 고려하고 있습니다.
 게임 개발 경험이 없더라도 흥미가 있다면 충분히 참여 가능합니다.
 마감 기한 없이 여유롭게 진행되는 만큼 즐겁게 협업하고 싶은 분을 찾습니다.',
 '모집중', '게임', 4, '전라남도', 6, 190, '2025-04-09 09:45:00', 9);




INSERT INTO project_stack (project_id, stack) VALUES
(1, 'security'),
(1, 'Adobe_XD'),
(1, 'NestJS'),
(1, 'MySQL'),
(2, 'Vue'),
(2, 'HTML'),
(2, 'MySQL'),
(3, 'NestJS'),
(3, 'MySQL'),
(3, 'Illustrator'),
(3, 'Java'),
(4, 'NestJS'),
(4, 'MongoDB'),
(4, 'security'),
(5, 'React'),
(5, 'Docker'),
(5, 'security'),
(5, 'Illustrator'),
(6, 'IoT'),
(6, 'Java'),
(6, 'C_PLUS'),
(7, 'Docker'),
(7, 'security'),
(8, 'NestJS'),
(8, 'Spring'),
(8, 'HTML'),
(9, 'security'),
(9, 'Java'),
(10, 'security'),
-- 11: React 기반 프론트엔드
(11, 'React'),
(11, 'JavaScript'),
(11, 'CSS'),
-- 12: Java + Spring 백엔드
(12, 'Java'),
(12, 'Spring'),
(12, 'MySQL'),
(12, 'Docker'),
-- 13: 디자이너 중심
(13, 'Figma'),
(13, 'Adobe_XD'),
(13, 'Illustrator'),
-- 14: 모바일 앱 (Flutter 제외)
(14, 'Android'),
(14, 'Kotlin'),
-- 15: AI 추천 시스템
(15, 'Python'),
(15, 'AI'),
(15, 'BigData'),
-- 16: Unity 게임
(16, 'Unity'),
(16, 'C_SHARP'),
-- 17: 프론트-디자인 협업
(17, 'React'),
(17, 'Figma'),
(17, 'CSS'),
-- 18: React Native
(18, 'React'),
(18, 'JavaScript'),
-- 19: AI 챗봇
(19, 'Python'),
(19, 'AI'),
(19, 'Docker'),
-- 20: 웹 미니게임
(20, 'JavaScript'),
(20, 'HTML'),
(20, 'CSS');


INSERT INTO project_applicant (accepted, user_id, project_id) VALUES
                                                          (false, 1, 1),
                                                          (false, 2, 1),
                                                          (true, 3, 2);

INSERT INTO project_comment (message, created_at, project_id, user_id) VALUES
       ('참여하고 싶어요!', '2025-05-14 04:20:58', 1, 2),
       ('좋은 프로젝트네요!', '2025-05-14 04:20:58', 2, 1),

-- project_id 11
       ('안녕하세요! 프론트엔드로 꼭 참여하고 싶습니다.', '2025-05-14 09:15:00', 11, 5),
       ('UI/UX 개선에도 기여할 수 있을 것 같아요!', '2025-05-14 09:17:22', 11, 4),
       ('컴포넌트 설계에 관심 많습니다. 함께 하고 싶어요!', '2025-05-14 09:20:45',11,1),

-- project_id 12
       ('백엔드 경험 쌓고 싶어서 지원합니다.', '2025-05-14 10:10:05', 12, 1),
       ('Swagger 사용해본 경험 있어요. 함께 하고 싶어요.', '2025-05-14 10:12:44',12, 7),

-- project_id 13
       ('디자인 시스템 구축에 관심 많아요.', '2025-05-14 11:03:20',13, 8),

-- project_id 14
       ('Flutter 프로젝트에 꼭 참여해보고 싶어요.', '2025-05-14 12:22:10', 14, 5),
       ('Firebase로 작업해본 경험 있어요. 팀에 도움되고 싶어요.', '2025-05-14 12:24:33', 14,6),
       ('모바일 앱 개발 실전 경험 쌓고 싶어요!', '2025-05-14 12:27:01',14, 3),
       ('기획 단계부터 함께하고 싶습니다.', '2025-05-14 12:29:55', 14,4),

-- project_id 15
       ('AI 추천 시스템 너무 흥미롭네요!', '2025-05-14 13:01:00',15,2),
       ('머신러닝 공부 중인데 꼭 참여하고 싶습니다.', '2025-05-14 13:03:27',15, 6),

-- project_id 16
       ('Unity로 간단한 게임 만들어 본 경험 있어요.', '2025-05-14 13:55:00',16, 9),
       ('게임 기획에도 관심 있어요. 팀에 기여하고 싶습니다.', '2025-05-14 13:58:12', 16, 3),
       ('2D 게임 구현은 자신 있습니다.', '2025-05-14 14:00:30',16, 7),

-- project_id 17
       ('디자인-프론트 협업 경험 있어요. 함께 하고 싶어요.', '2025-05-14 14:30:00', 17,4),
       ('스타일 가이드 제작 관심 있어서 지원합니다.', '2025-05-14 14:32:49', 17, 8),

-- project_id 18
       ('React Native 앱 개발 관심 있어서 지원해요!', '2025-05-14 15:10:10', 18,5),

-- project_id 19
       ('자연어처리 공부하고 있는데 실전 경험 쌓고 싶어요.', '2025-05-14 16:05:00', 19,6),
       ('AI 챗봇 흥미롭네요! 함께 하게 되면 좋겠어요.', '2025-05-14 16:07:21',19, 1),
       ('Transformer 기반 모델 적용 경험 있습니다.', '2025-05-14 16:09:40', 19,2),

-- project_id 20
       ('게임 기획과 구현 다 경험해보고 싶습니다.', '2025-05-14 17:00:00', 20,9),
       ('간단한 HTML5 게임 개발 재밌을 것 같아요. 참여하고 싶습니다.', '2025-05-14 17:02:45', 20,2);


INSERT INTO project_like (project_id, user_id) VALUES
                                                   (1, 2),
                                                   (2, 3);

INSERT INTO notification (receiver_id, message, is_read, target_id, type, created_at) VALUES
      (1, 'bob님이 프로젝트에 지원했습니다.', false, 1, 'APPLY', '2025-05-14 04:20:58'),
      (1, 'charlie님이 댓글을 남겼습니다.', false, 2, 'COMMENT', '2025-05-14 04:20:58'),
      (1, 'bob님이 좋아요를 눌렀습니다.', false, 1, 'LIKE', '2025-05-14 04:20:58');
