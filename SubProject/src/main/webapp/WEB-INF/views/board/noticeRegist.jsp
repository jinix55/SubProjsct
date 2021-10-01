<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="content">
    <div class="content_tit">
        <h1 class="content_h1">공지사항</h1>
        <ul class="content_nav">
            <li>HOME</li>
            <li>시스템 관리</li>
            <li>공지사항</li>
        </ul>
    </div>

    <form>
        <table class="tb02" summary="번호, 등록일, 제목, 게시여부, 중요여부, 내용, 첨부파일에 대한 내용입니다.">
            <caption class="hidden">공지사항 등록</caption>
            <colgroup>
                <col style="width:12.5%">
                <col style="width:37.5%">
                <col style="width:12.5%">
                <col style="width:37.5%">
            </colgroup>
            <tbody>
            <tr>
                <th scope="row">번호</th>
                <td class="tc">111</td>
                <th scope="row">등록일</th>
                <td class="tc">111</td>
            </tr>
            <tr>
                <th scope="row"><label for="data01">제목</label></th>
                <td colspan="3"><input type="text" class="input" id="data01" value="공지사항"></td>
            </tr>
            <tr>
                <th scope="row"><label for="data02">게시여부</label></th>
                <td>
                    <div class="select">
                        <select name="data02" id="data02" class="tc">
                            <option value="게시">게시</option>
                        </select>
                    </div>
                </td>
                <th scope="row"><label for="data03">중요여부</label></th>
                <td>
                    <div class="select">
                        <select name="data03" id="data03" class="tc">
                            <option value="중요">중요</option>
                        </select>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="data04">내용</label></th>
                <td colspan="3"><div class="textarea">
                    <textarea name="data04" id="data04"></textarea>
                </div></td>
            </tr>
            <tr>
                <th scope="row">첨부파일</th>
                <td colspan="3">
                    <div class="drag_drop">
                        <div class="drag_drop_bg">Drag & Drop</div>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>

        <div class="btn_wrap tr">
            <button type="submit" class="btn big orange">저장</button>
            <button type="button" class="btn big grayb" onclick="location.href='/board/notice'">목록</button>
        </div>
    </form>

</section>
