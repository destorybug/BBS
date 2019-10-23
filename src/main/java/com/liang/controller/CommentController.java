package com.liang.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.liang.bean.Comment;
import com.liang.bean.Message;
import com.liang.service.ArticleService;
import com.liang.service.CommentService;
import com.liang.service.MessageService;

@RequestMapping("/commentController")
@Controller
public class CommentController {

	@Autowired
	CommentService commentService;
	@Autowired
	MessageService messageService;
	@Autowired
	ArticleService articleService;
	
	
	/**
	 * 按帖子id（fid）查询评论表信息
	 * @param fid
	 * @param map
	 */
	@RequestMapping("/getCommentFid")
	public void getCommentFid(int fid,Map<Object, Object> map) {
		
		List<Comment> listComment = commentService.getCommentFid(fid);
		map.put("listComment", listComment);
	}
	
	/**
	 * 添加评论
	 * @param comment
	 */
	@RequestMapping("/setComment")
	public String setComment(Comment comment) {
		
		System.out.println(comment);
		commentService.setComment(comment);
		Message message=new Message();
		int userid = articleService.getArticleKey(comment.getFid()).getUserid();
		message.setMcontent("该用户对你的编号为" + comment.getFid() + "进行了评论！");
		message.setStatus(0);
		message.setTime(comment.getTime());
		message.setUserid(userid);
		message.setBeuserid(comment.getUserid());
		message.setFid(comment.getFid());
		messageService.setMessage(message);
		return "redirect:/index.jsp";
	}
	
	/**
	 * 按pid删除评论表
	 * @return
	 */
	@RequestMapping("/deleteComment")
	public ModelAndView  deleteComment(Comment comment) {
		
		System.out.println(comment);
		Message message=new Message();
		int userid = articleService.getArticleKey(comment.getFid()).getUserid();
		message.setMcontent("该用户对你的编号为" + comment.getFid() + "删除了评论！");
		message.setStatus(0);
		message.setTime(comment.getTime());
		message.setUserid(userid);
		message.setBeuserid(comment.getUserid());
		message.setFid(comment.getFid());
		commentService.deleteComment(comment.getPid());
		messageService.setMessage(message);
		//重定向到getMyself这个方法
		return new ModelAndView("redirect:/userController/getMyself");
	}
	
	
	
}
