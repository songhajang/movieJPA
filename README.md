# 🎬 movieJPA – 영화 소개 & 필터링 사이트

**영화 카테고리와 필터 기능을 구현한 JPA 기반 영화 추천 사이트**입니다.  
Tailwind CSS 기반의 모던한 UI와 JPA를 통한 데이터 연동으로,  
사용자가 원하는 장르(카테고리)를 선택하거나 검색어를 입력해 쉽게 영화를 탐색할 수 있습니다.


## 👤 팀원 소개
<table>
  <tbody>
    <tr>
      <td align="center"><a href="https://github.com/moonstone0514"><img src="https://github.com/moonstone0514.png" width="100px;" alt=""/><br /><sub><b>@moonstone0514</b></sub></a><br /></td>
      <td align="center"><a href="https://github.com/songhajang"><img src="https://github.com/songhajang.png" width="100px;" alt=""/><br /><sub><b>@songhajang</b></sub></a><br /></td>
      <td align="center"><a href="https://github.com/yeomyeoung"><img src="https://github.com/yeomyeoung.png" width="100px;" alt=""/><br /><sub><b>@yeomyeoung</b></sub></a><br /></td>
      <td align="center"><a href=""><img src=".png" width="100px;" alt=""/><br /><sub><b>@yeomyeoung</b></sub></a><br /></td>

  </tbody>
</table>

---

## 📌 프로젝트 개요
- **Backend** : Java / Servlet / JPA
- **Frontend** : HTML, Tailwind CSS (다크모드 지원), JSP
- **DB** : Oracle
- **기능** :
  - 장르별 영화 목록 필터링
  - 영화 제목 검색
  - JPA를 통한 Entity 매핑 및 CRUD
  - 다크 모드 전환 버튼
  - 로딩 화면(애니메이션) 제공

---

## ✨ 주요 화면
- **로딩 화면** : 사이트 진입 시 애니메이션과 함께 “로딩 중” 표시
- **사이드바** : 액션, 드라마, 코미디, SF, 애니메이션 카테고리
- **검색창** : 영화 제목 검색
- **카드 리스트** : 장르 필터링된 영화 리스트 표시
- **다크모드 토글** : 실시간 테마 변경 지원

---

## 🛠️ 기술 스택
| 구분 | 사용 기술 |
|------|-----------|
| Language | Java 17, HTML5, CSS3, JavaScript |
| Frontend | TailwindCSS, JSP, JSTL |
| Backend | Servlet, JPA (Hibernate) |
| DB | MySQL (JPA 연동), persistence.xml 설정 |
| Build Tool | Maven |


<!-- ---

## 📂 주요 디렉토리 구조

```
movieJPA/
├─ src/main/java/
│   ├─ controller/
│   │    └─ movieRankController.java   # Servlet Controller
│   ├─ model/
│   │    ├─ MovieModel.java            # JPA 쿼리 처리
│   │    └─ entity/Movie.java          # JPA Entity
│   └─ util/
│        └─ DBUtil.java                # EntityManager 유틸
├─ src/main/webapp/
│   ├─ index.jsp                       # 메인 뷰
│   └─ WEB-INF/
│        └─ web.xml
├─ resources/
│   └─ META-INF/persistence.xml        # JPA 설정
├─ pom.xml
└─ README.md
``` -->
---

## 🔑 주요 코드 설명

### ✅ **DBUtil.java**
```java
private static EntityManagerFactory emf;
static {
    emf = Persistence.createEntityManagerFactory("movieProject");
}
public static EntityManager getEntityManager() {
    return emf.createEntityManager();
}
````

👉 JPA `EntityManager`를 관리하기 위한 유틸 클래스입니다.

---

### ✅ **Movie Entity**

```java
@Entity
@Table(name = "MOVIE")
public class Movie {
    @Id
    @Column(name = "\"userId\"")
    private long userId;

    @Column(name = "\"movieId\"")
    private long movieId;

    @Column(name = "\"rating\"")
    private double rating;

    @Column(name = "\"title\"")
    private String title;

    @Column(name = "\"genres\"")
    private String genres;
}
```

👉 `MOVIE` 테이블을 매핑한 JPA 엔티티입니다.

---

### ✅ **MovieModel.java**

```java
public static List<Movie> getMovieList() {
    EntityManager em = DBUtil.getEntityManager();
    return em.createQuery("select m from Movie m", Movie.class).getResultList();
}

public static List<Movie> getMovieListByGenre(String genreName) {
    EntityManager em = DBUtil.getEntityManager();
    return em.createQuery(
        "SELECT m FROM Movie m WHERE m.genres LIKE :genreName", Movie.class)
        .setParameter("genreName", "%" + genreName + "%")
        .getResultList();
}
```

👉 전체 목록 조회 및 장르 기반 필터링을 처리하는 메서드입니다.

---

### ✅ **movieRankController.java**

```java
@WebServlet("/test")
public class movieRankController extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String genreName = req.getParameter("genreName");
        List<Movie> result = (genreName != null && !genreName.isEmpty())
            ? MovieModel.getMovieListByGenre(genreName)
            : MovieModel.getMovieList();

        req.setAttribute("datas", result);
        req.getRequestDispatcher("index.jsp").forward(req, res);
    }
}
```

👉 클라이언트에서 전달받은 `genreName` 파라미터로 필터링 후 JSP에 전달합니다.
---
## 📌 SQL 구문

```sql
-- 전체 영화 목록 조회
SELECT * FROM MOVIE;

-- 특정 장르가 포함된 영화 목록 조회
SELECT * FROM MOVIE
WHERE genres LIKE '%액션%';
````

👉 JDBC에서는 `PreparedStatement`로 위 구문을 직접 작성하고, `?` 파라미터를 수동으로 바인딩해야 했습니다.

---

## 📌 JPA에서의 JPQL (Java Persistence Query Language)

JPA에서는 SQL을 그대로 쓰지 않고 **엔티티 객체를 기준으로 하는 JPQL**을 사용합니다.

```java
// 전체 목록
"SELECT m FROM Movie m"

// 장르 필터링
"SELECT m FROM Movie m WHERE m.genres LIKE :genreName"
```

👉 `MOVIE` 테이블 이름이 아닌 **Movie 엔티티 클래스명**을 대상으로 쿼리를 작성합니다.

---

## ✨ JPA에서 사용한 특별한 점

| 포인트          | 설명                                                                         |
| ------------ | -------------------------------------------------------------------------- |
| `LIKE`       | SQL의 LIKE와 동일한 기능을 JPQL에서도 사용 가능. `%` 와일드카드를 함께 사용하여 부분 검색을 지원.            |
| `:genreName` | 문자열 결합 대신 **Named Parameter**(`:파라미터명`)를 사용. `setParameter()`로 안전하게 값 바인딩. |

---

## 🔑 SQL과 JPQL의 간단 비교

| 구분    | SQL             | JPQL             |
| ----- | --------------- | ---------------- |
| 작성 기준 | 데이터베이스 테이블      | 엔티티 클래스          |
| 컬럼 명  | 실제 DB 컬럼        | 엔티티 필드명          |
| 파라미터  | `?` (인덱스 기반)    | `:이름` (네임드 파라미터) |
| 결과 처리 | ResultSet 수동 매핑 | 엔티티 자동 매핑        |


---

## 📷 UI 미리보기

> 🎨 Tailwind CSS로 제작된 UI (다크모드 지원)

* 로딩 화면
* 사이드바 카테고리
* 영화 카드 리스트
* 검색창 및 필터 기능

(스크린샷 추가 예정)

---

## ✅ 개선 및 추가 예정

* [ ] 관리자 페이지(영화 추가/수정/삭제)
* [ ] 영화 상세 페이지 구현
* [ ] React/Vue 프런트엔드 연동
* [ ] Dockerfile 작성 및 배포 자동화