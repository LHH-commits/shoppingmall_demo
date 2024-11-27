package com.shoppingmall.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import java.util.List;
import java.security.Principal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.shoppingmall.demo.service.ProductService;
import com.shoppingmall.demo.service.ReviewService;
import com.shoppingmall.demo.service.UserService;
import com.shoppingmall.demo.service.CategoryService;

import com.shoppingmall.demo.domain.Review;
import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.domain.Users;
import com.shoppingmall.demo.domain.Category;

@Controller
@RequestMapping("/review")
public class ReviewController {
    Logger logger = LoggerFactory.getLogger(ReviewController.class);

    @Autowired
    ReviewService reviewservice;

    @Autowired
    ProductService productservice;

    @Autowired
    UserService userservice;

    @Autowired
    CategoryService categoryservice;

    // 리뷰 작성
    @PostMapping("/insert")
    @ResponseBody
    public ResponseEntity<?> writeReview(
            @RequestParam("pId") int pId,
            @RequestParam("rContent") String rContent,
            @RequestParam("rScore") int rScore,
            @AuthenticationPrincipal UserDetails userDetails, Model model) {
        
        try {
            // 점수 범위 체크
            if (rScore < 1 || rScore > 5) {
                return ResponseEntity.badRequest().body("평점은 1-5점 사이로 입력해주세요.");
            }

            // 사용자 정보 조회
            Users user = userservice.readUser(userDetails.getUsername());
            // 상품 정보 조회
            Product product = productservice.selectProductPid(pId);

            if (product == null) {
                return ResponseEntity.badRequest().body("존재하지 않는 상품입니다.");
            }

            Review review = new Review();
            review.setpId(pId);
            review.setrContent(rContent);
            review.setrScore(rScore);
            review.setrWriter(user.getuName());  // 사용자 이름을 작성자로
            review.setuId(user.getuId());

            reviewservice.insertReview(review);
            return ResponseEntity.ok("리뷰가 등록되었습니다.");

        } catch (Exception e) {
            logger.error("리뷰 작성 중 오류 발생: ", e);
            return ResponseEntity.badRequest().body("리뷰 작성 중 오류가 발생했습니다.");
        }
    }

    @GetMapping("/insert")
    public String insertReviewForm(
            @RequestParam("pId") int pId, 
            @AuthenticationPrincipal UserDetails userDetails, 
            Model model) {
        //HomeUI에서 카테고리 정보 전달
        List<Category> cList = categoryservice.selectTierCategory();
        model.addAttribute("cList", cList);

        Product product = productservice.selectProductPid(pId);

        // 이미 리뷰를 작성했는지 확인
        Review existingReview = reviewservice.getReviewByUserAndProduct(userDetails.getUsername(), pId);
        if (existingReview != null) {
            // 이미 리뷰가 있으면 리뷰 목록 페이지로 리다이렉트
            return "redirect:/review/list?message=already_exists";
        }
        model.addAttribute("product", product);
        return "/review/insert";
    }

    // 상품별 리뷰 목록 조회
    @GetMapping("/list/{pId}")
    @ResponseBody
    public ResponseEntity<?> getReviewList(@PathVariable int pId) {
        try {
            List<Review> reviews = reviewservice.ListReviewByPid(pId);
            return ResponseEntity.ok(reviews);
        } catch (Exception e) {
            logger.error("리뷰 목록 조회 중 오류 발생: ", e);
            return ResponseEntity.badRequest().body("리뷰 목록 조회 중 오류가 발생했습니다.");
        }
    }

    // 리뷰 수정
    @PostMapping("/update")
    @ResponseBody
    public String updateReview(
            @RequestParam("rId") int rId,
            @RequestParam("rContent") String rContent,
            @RequestParam("rScore") int rScore) {
        try {
            Review review = new Review();
            review.setrId(rId);
            review.setrContent(rContent);
            review.setrScore(rScore);
            reviewservice.updateReview(review);
            return "리뷰가 수정되었습니다.";
        } catch (Exception e) {
            return "리뷰 수정 중 오류가 발생했습니다.";
        }
    }

    // 리뷰 삭제
    @PostMapping("/delete")
    @ResponseBody
    public String deleteReview(@RequestParam("rId") int rId) {
        try {
            reviewservice.deleteReviewByRid(rId);
            return "리뷰가 삭제되었습니다.";
        } catch (Exception e) {
            logger.error("리뷰 삭제 실패", e);
            return "리뷰 삭제 중 오류가 발생했습니다.";
        }
    }

    // 상품의 평균 평점 조회
    @GetMapping("/average/{pId}")
    @ResponseBody
    public ResponseEntity<?> getAverageScore(@PathVariable int pId) {
        try {
            List<Review> reviews = reviewservice.ListReviewByPid(pId);
            if (reviews.isEmpty()) {
                return ResponseEntity.ok(0.0);
            }
            
            double averageScore = reviews.stream()
                .mapToInt(Review::getrScore)
                .average()
                .orElse(0.0);
                
            return ResponseEntity.ok(averageScore);
        } catch (Exception e) {
            logger.error("평균 평점 조회 중 오류 발생: ", e);
            return ResponseEntity.badRequest().body("평균 평점 조회 중 오류가 발생했습니다.");
        }
    }

    @GetMapping("/list")
        public String getMyReviews(Model model, Principal principal) {
            //HomeUI에서 카테고리 정보 전달
            List<Category> cList = categoryservice.selectTierCategory();
            model.addAttribute("cList", cList);

            String username = principal.getName();
            List<Review> reviews = reviewservice.getReviewsByUid(username);
            model.addAttribute("reviews", reviews);
            return "/review/list";
    }
}
