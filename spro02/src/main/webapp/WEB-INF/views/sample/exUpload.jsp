<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업로드</title>
</head>
<body>
  <form action="/sample/exUploadPost" method="post" encType="multipart/form-data">
    <input type="file" name="files">파일 업로드1<br>
    <input type="file" name="files">파일 업로드2<br>
    <input type="file" name="files">파일 업로드3<br>
    <input type="file" name="files">파일 업로드4<br>
    <input type="file" name="files">파일 업로드5<br>
    <input type="submit" value="업로드">
  </form>
</body>
</html>