package com.shoppingmall.demo.service;

import java.util.List;
import java.util.Map;

import com.shoppingmall.demo.domain.Board;
import com.shoppingmall.demo.domain.Pagination;

public interface BoardService {
    // 게시물 목록
    public List<Board> selectBoardList(Map<String, Object> params);

    // 각 게시판 유형별 카운트
    public int countBoardByType(String bType);

    // 게시물 작성(추가)
    public void insertBoard(Board board);

    // 게시물 상세 조회
    public Board selectBoardBid(int bId);

    // 게시물 삭제
    public void deleteBoard(int bId);

    // 게시물 수정
    public void updateBoard(Board board);

    // 조회수 증가 없이 게시글 조회
    Board selectBoardBidNoCount(int bId);
}
