package com.liang.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.liang.bean.Attention;
import com.liang.bean.Message;
import com.liang.service.ArticleService;
import com.liang.service.AttentionService;
import com.liang.service.MessageService;

@RequestMapping("/attentionController")
@Controller
public class AttentionController {

	@Autowired
	AttentionService attentionService;
	@Autowired
	ArticleService articleService;
	@Autowired
	MessageService messageService;
	
	/**
	 * 添加关注
	 * @return
	 */
	@RequestMapping("/setAttention")
	public String setAttention(Attention attention) {
		Message message=new Message();
		message.setMcontent("该用户关注了你！");
		message.setStatus(0);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = dateFormat.format(new Date());
		message.setTime(date);
		message.setUserid(attention.getBeuserid());
		message.setBeuserid(attention.getUserid());
		messageService.setMessage(message);
		attentionService.setAttention(attention);
		return "redirect:/index.jsp";//重定向
	}
	
	
	/**
	 * 取消关注（首页）
	 * @param attention
	 * @return
	 */
	@RequestMapping("/deleteAttention")
	public String deleteAttention(Attention attention) {
		Message message=new Message();
		message.setMcontent("该用户取关了你！");
		message.setStatus(0);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = dateFormat.format(new Date());
		message.setTime(date);
		message.setUserid(attention.getBeuserid());
		message.setBeuserid(attention.getUserid());
		messageService.setMessage(message);
		attentionService.deleteAttention(attention);
		return "redirect:/index.jsp";
	}
	
	/**
	 * 取消关注（个人主页）
	 * @param attention
	 * @return
	 */
	@RequestMapping("/deleteAttentionMyself")
	public ModelAndView deleteAttentionMyself(Attention attention) {
		Message message=new Message();
		message.setMcontent("该用户取关了你！");
		message.setStatus(0);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = dateFormat.format(new Date());
		message.setTime(date);
		message.setUserid(attention.getBeuserid());
		message.setBeuserid(attention.getUserid());
		messageService.setMessage(message);
		attentionService.deleteAttentionMyself(attention);
		return new ModelAndView("redirect:/userController/getMyself");
	}
	
	
}
