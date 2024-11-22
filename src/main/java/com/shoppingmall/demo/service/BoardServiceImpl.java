package com.shoppingmall.demo.service;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.shoppingmall.demo.domain.Board;
import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Autowired
    BoardMapper boardmapper;

    @Override
    public List<Board> selectBoardList(Map<String, Object> params) {
        return boardmapper.selectBoardList(params);
    }

    @Override
    public int countBoardByType(String bType) {
        return boardmapper.countBoardByType(bType);
    }

    @Override
    public void insertBoard(Board board) {
        boardmapper.insertBoard(board);
    }
    
    @Transactional
    @Override
    public Board selectBoardBid(int bId) {
        logger.debug("조회수 증가 시작: bId = {}", bId);
        boardmapper.countViews(bId);
        logger.debug("조회수 증가 완료");
        return boardmapper.selectBoardBid(bId);
    }

    @Override
    public void deleteBoard(int bId) {
        boardmapper.deleteBoard(bId);
    }

    @Override
    public void updateBoard(Board board) {
        boardmapper.updateBoard(board);
    }

    @Override
    public Board selectBoardBidNoCount(int bId) {
        return boardmapper.selectBoardBid(bId);
    }
}
