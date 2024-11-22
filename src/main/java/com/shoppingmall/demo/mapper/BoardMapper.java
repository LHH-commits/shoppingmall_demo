package com.shoppingmall.demo.mapper;

import com.shoppingmall.demo.domain.Board;
import java.util.List;
import com.shoppingmall.demo.domain.Pagination;
import org.apache.ibatis.annotations.Mapper;
import java.util.Map;

@Mapper
public interface BoardMapper {
    // 게시물 목록 - Map으로 파라미터 변경
    public List<Board> selectBoardList(Map<String, Object> params);

    // 각 게시판 유형별 카운트
    public int countBoardByType(String bType);

    // 게시물 작성(추가)
    public void insertBoard(Board board);

    // 게시물 상세 조회
    public Board selectBoardBid(int bId);

    // 게시물 조회수 증가
    public void countViews(int bId);

    // 게시물 삭제
    public void deleteBoard(int bId);

    // 게시물 수정
    public void updateBoard(Board board);
}
