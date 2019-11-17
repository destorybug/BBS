package com.liang.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.liang.bean.Article;
import com.liang.bean.Collect;
import com.liang.bean.Message;
import com.liang.service.ArticleService;
import com.liang.service.CollectService;
import com.liang.service.MessageService;

@RequestMapping("/collectController")
@Controller
public class CollectController {

	@Autowired
	CollectService collectService;
	@Autowired
	MessageService messageService;
	@Autowired
	ArticleService articleService;
	
	
	/**
	 * 删除收藏（按sid）
	 * @param collect
	 * @return
	 */
	@RequestMapping("/deleteCollect")
	public String deleteCollect(Collect collect) {
		Article article = articleService.getArticleKey(collect.getFid());
		Message message=new Message();
		message.setMcontent("该用户取消收藏你编号为" + collect.getFid() + "的帖子");
		message.setStatus(0);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = dateFormat.format(new Date());
		message.setTime(date);
		message.setFid(collect.getFid());
		message.setUserid(article.getUserid());
		message.setBeuserid(collect.getUserid());
		messageService.setMessage(message);
		collectService.deleteCollect(collect);
		return "redirect:/index.jsp";//重定向
	}
	
	/**
	 * 删除收藏（按userid和fid）
	 * @param collect
	 * @return
	 */
	@RequestMapping("/deleteCollectUseridAndFid")
	public String deleteCollectUseridAndFid(Collect collect) {
		Article article = articleService.getArticleKey(collect.getFid());
		Message message=new Message();
		message.setMcontent("该用户取消收藏你编号为" + collect.getFid() + "的帖子");
		message.setStatus(0);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = dateFormat.format(new Date());
		message.setTime(date);
		message.setFid(collect.getFid());
		message.setUserid(article.getUserid());
		message.setBeuserid(collect.getUserid());
		messageService.setMessage(message);
		System.out.println(collect);
		collectService.deleteCollectUseridAndFid(collect);
		return "redirect:../userController/getMyself";//重定向
	}
	
	/**
	 * 添加收藏
	 * @param collect
	 * @return
	 */
	@RequestMapping("/setCollect")
	public String setCollect(Collect collect) {
		Article article = articleService.getArticleKey(collect.getFid());
		Message message=new Message();
		message.setMcontent("该用户收藏你编号为" + collect.getFid() + "的帖子");
		message.setStatus(0);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date = dateFormat.format(new Date());
		message.setTime(date);
		message.setFid(collect.getFid());
		message.setUserid(article.getUserid());
		message.setBeuserid(collect.getUserid());
		messageService.setMessage(message);
		System.out.println(collect);
		collectService.setCollect(collect);
		return "redirect:/index.jsp";//重定向
	}
	
}
