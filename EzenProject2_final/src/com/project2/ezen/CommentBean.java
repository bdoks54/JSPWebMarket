package com.project2.ezen;

import java.sql.Date;

public class CommentBean {
	String num;
	String boardNum; //게시판 글번호
	String id;	//작성자 아이디
	Date date;
	String parentNum;	//대댓글을 위한 부모번호
	String content;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(String boardNum) {
		this.boardNum = boardNum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getParentNum() {
		return parentNum;
	}
	public void setParentNum(String parentNum) {
		this.parentNum = parentNum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
