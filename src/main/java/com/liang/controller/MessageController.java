package com.liang.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.liang.bean.Message;
import com.liang.service.ArticleService;
import com.liang.service.CommentService;
import com.liang.service.MessageService;

@RequestMapping("/messageController")
@Controller
public class MessageController {

	@Autowired
	MessageService messageService;
	@Autowired
	ArticleService articleService;
	@Autowired
	CommentService commentService;
	
	//删除指定消息
	@RequestMapping("/deleteMessage")
	public String deleteMessage(Message message) {
		
		messageService.deleteMessage(message.getMid());
		return "redirect:/index.jsp";//重定向
	}
	
	//删除用户的全部消息内容(userid)
	@RequestMapping("/deleteMessageUserid")
	public String deleteMessageUserid(Message message) {
		
		System.out.println(message);
		messageService.deleteMessageUserid(message.getUserid());
		return "redirect:/index.jsp";//重定向
	}
	
}
