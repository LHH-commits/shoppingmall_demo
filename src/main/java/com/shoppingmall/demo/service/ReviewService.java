package com.shoppingmall.demo.service;

import java.util.List;

import com.shoppingmall.demo.domain.Review;

public interface ReviewService {

	public void insertReview(Review review);
	
	public List<Review> ListReviewByPid(int pId);
	
	public Review getReviewByRid(int rId);
	
	public void deleteReviewByRid(int rId);
	
	public void deleteReviewByPid(int pId);
	
	public void updateReview(Review review);

	public List<Review> getReviewsByUid(String uId);

	public Review getReviewByUserAndProduct(String uId, int pId);
}
