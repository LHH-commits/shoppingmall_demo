package com.shoppingmall.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingmall.demo.domain.Review;
import com.shoppingmall.demo.mapper.ReviewMapper;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewMapper reviewmapper;
	
	@Override
	public void insertReview(Review review) {
		reviewmapper.insertReview(review);
	}
	
	@Override
	public List<Review> ListReviewByPid(int pId) {
		return reviewmapper.ListReviewByPid(pId);
	}
	
	@Override
	public Review getReviewByRid(int rId) {
		return reviewmapper.getReviewByRid(rId);
	}
	
	@Override
	public void deleteReviewByRid(int rId) {
		reviewmapper.deleteReviewByRid(rId);
	}
	
	@Override
	public void deleteReviewByPid(int pId) {
		reviewmapper.deleteReviewByPid(pId);
	}
	
	@Override
	public void updateReview(Review review) {
		reviewmapper.updateReview(review);
	}
}
