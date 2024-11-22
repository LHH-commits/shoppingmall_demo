package com.shoppingmall.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.shoppingmall.demo.domain.Review;

@Mapper
public interface ReviewMapper {

	public void insertReview(Review review);
	
	public List<Review> ListReviewByPid(int pId);
	
	public Review getReviewByRid(int rId);
	
	public void deleteReviewByRid(int rId);
	
	public void deleteReviewByPid(int pId);
	
	public void updateReview(Review review);
}
