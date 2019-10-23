package com.liang.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.liang.bean.Article;
import com.liang.bean.Article2;
import com.liang.bean.Message;
import com.liang.service.ArticleService;
import com.liang.service.CollectService;
import com.liang.service.CommentService;
import com.liang.service.MessageService;
import com.liang.utils.PathUtil;
import com.liang.utils.PropertyUtil;

@RequestMapping("/articleController")
@SessionAttributes(value= {"article_Edit","article_Show"})
@Controller
public class ArticleController {

	@Autowired
	ArticleService articleService;
	@Autowired
	CommentService commentService;
	@Autowired
	CollectService collectService;
	@Autowired
	MessageService messageService;
	
	/**
	 * 向数据库插入发帖信息（包括图片）
	 * 
	 * @param file
	 * @param article2
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("/setArticle")
	//有MultipartFile file的时候不能有 Article article，因为Article中包含了文件（file）????!!!
	public String setArticle(@RequestParam("photo") MultipartFile file, Article2 article2, HttpSession session,HttpServletRequest request)
			throws IOException {
		
		String projectname;	//项目名称
		projectname = request.getSession().getServletContext().getRealPath("/");
		projectname=projectname.substring(0,projectname.length()-1);
		if (projectname.indexOf("/")==-1) {//在非linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("\\"),projectname.length());
		} else {//在linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("/"),projectname.length());
		}
		System.out.println("111111111111111111111111:"+projectname);

		//文件（图片）路径
		String filePath = PathUtil.getCommonPath()+projectname+PathUtil.getArticlePath();
		//用于存放新生成的文件名字(不重复)
		String newFileName = "photo";
		
		String username=(String) session.getAttribute("username");
		System.out.println(username!=null);
		//用户登录情况下才可发帖
		if(username!=null) {
			
			//当其中没有值时"int userid=null"报错(肯定报错啊，int=null???)
			int userid=(int) session.getAttribute("userid");
			
			// 获取上传图片的文件名及其后缀(获取原始图片的拓展名)
			String fileName = file.getOriginalFilename();
			
			if(!fileName.equals("")) {
				//生成新的文件名字(不重复)
				newFileName = UUID.randomUUID() + fileName;
				// 封装上传文件位置的全路径
				File targetFile = new File(filePath, newFileName);
				System.out.println(fileName);
				System.out.println(targetFile);
				// 把本地文件上传到封装上传文件位置
				file.transferTo(targetFile);
			}
			
			// 将article2和photo整合到article中
			Article article = new Article(article2, newFileName);

			article.setUserid(userid);
			article.setUsername(username);
			article.setStatus(0);

			// 将article保存到数据库
			articleService.setArticle(article);
		}
		
		return "redirect:/index.jsp";//重定向 
	}
	
	/**
	 * 查询发帖表信息（无条件）
	 * @param map
	 */
	public void getArticle(Map<Object, Object> map) {
		
		List<Article> listArticle = articleService.getArticle();
		map.put("listArticle", listArticle);
		
	}
	
	/**
	 * 按帖子标题模糊查询（搜索框搜索）
	 * @param articleTitle
	 * @param map
	 */
	public void getArticleTitle(String articleTitle,Map<Object, Object> map) {
		
		List<Article> listArticle = articleService.getArticleTitle(articleTitle);
		map.put("listArticle", listArticle);
	}
	
	/**
	 * 按用户兴趣查询
	 * @param articleTitle
	 * @param map
	 
	public void getUserHabbit(String articleTitle,Map<Object, Object> map) {
		
		List<Article> listArticle = articleService.getArticleTitle(articleTitle);
		map.put("listArticle", listArticle);
	}*/
	
	
	/**
	 * 按帖子板块查询出帖子
	 * @param bname
	 * @param map
	 */
	public void getArticleBname(String bname, Map<Object, Object> map) {
		
		List<Article> listArticle = articleService.getArticleBname(bname);
		map.put("listArticle", listArticle);
	}
	

	/**
	 * 按fid删除帖子
	 * @param article
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/deleteArticle")
	public ModelAndView deleteArticle(Article article,HttpServletRequest request) throws IOException {
		
		int fid=article.getFid();
		int count=commentService.getCommentFid(fid).size();
		
		//不能将commentService.getCommentFid(fid).size();放在for()里面，因为：
		//因为每一次commentService.deleteComment(pid)都会删除一条记录，总记录就会少一条，
		//自然commentService.getCommentFid(fid).size()就会减一。
		for(int i=0;i<count;i++) {
			
			//为啥用get(0)，而不用get(i)？
			//因为每一次commentService.deleteComment(pid)都会删除一条记录，总记录就会少一条，自然之前的get(1)就变成了现在的get(0)
			//以此递推，故为get(0)，而不是get(i);
			int pid=commentService.getCommentFid(fid).get(0).getPid();
			
			//删除帖子下对应的评论（注意：先删评论再删帖子！！）
			commentService.deleteComment(pid);
		}
		
		//调用删除帖子对应图片的方法
		articlePhotoDelete(fid,request);
		//删除帖子(数据库)
		articleService.deleteArticle(fid);
		
		//删除有该帖子id的收藏信息
		collectService.deleteCollectFid(fid);
		
		//删除该用户对应的收藏信息(按userid)
		collectService.deleteCollectFid(fid);
		
		//重定向到getMyself这个方法
		return new ModelAndView("redirect:/userController/getMyself");
	}
	
	/**
	 * 获取mycontent.jsp页面传来的数据，并将其保存在map("article")中，以便articleEdit.jsp页面使用
	 * @param article
	 * @param map
	 * @return
	 */
	@RequestMapping("/getUpdateArticle")
	public String getUpdateArticle(Article article, Map<Object, Object> map) {
		
		map.put("article_Edit", article);
		
		return "redirect:/content/articleEdits.jsp";
	}
	
	/**
	 * 修改帖子表
	 * @param article
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/updateArticle")
	public ModelAndView updateArticle(@RequestParam("photo") MultipartFile file, Article2 article2,HttpServletRequest request) throws IOException {
		
		String projectname;	//项目名称
		projectname = request.getSession().getServletContext().getRealPath("/");
		projectname=projectname.substring(0,projectname.length()-1);
		if (projectname.indexOf("/")==-1) {//在非linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("\\"),projectname.length());
		} else {//在linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("/"),projectname.length());
		}

		//文件（图片）路径
		String filePath = PathUtil.getCommonPath()+projectname+PathUtil.getArticlePath();
		
		int fid=article2.getFid();
		
		// 获取上传图片的文件名及其后缀(获取原始图片的拓展名)
		String fileName = file.getOriginalFilename();
		// 生成新的文件名字(不重复)
		String newFileName = UUID.randomUUID() + fileName;
		// 封装上传文件位置的全路径
		File targetFile = new File(filePath, newFileName);
		System.out.println(targetFile);
		// 把本地文件上传到封装上传文件位置的全路径
		file.transferTo(targetFile);

		// 将article2和photo整合到article中
		Article article = new Article(article2, newFileName);
		
		//调用删除帖子对应图片的方法
		articlePhotoDelete(fid,request);
		//修改帖子表（数据库）
		articleService.updateArticle(article);
		
		//重定向到getMyself这个方法
		return new ModelAndView("redirect:/userController/getMyself");
	}
	
	
	/**
	 * 删除帖子对应的图片
	 * @throws IOException 
	 */
	public void articlePhotoDelete(int fid,HttpServletRequest request) throws IOException {
		
		String projectname;	//项目名称
		projectname = request.getSession().getServletContext().getRealPath("/");
		projectname=projectname.substring(0,projectname.length()-1);
		if (projectname.indexOf("/")==-1) {//在非linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("\\"),projectname.length());
		} else {//在linux系统下
			projectname = projectname.substring(projectname.lastIndexOf("/"),projectname.length());
		}

		//文件（图片）路径
		String filePath = PathUtil.getCommonPath()+projectname+PathUtil.getArticlePath();
		
		// 获取取要删除帖子对应的图片的文件名（通过fid获取帖子信息）
		String fileName = articleService.getArticleKey(fid).getPhoto();
		// 封装上传文件位置的全路径
		File targetFile = new File(filePath, fileName);
		
		//删除帖子对应的图片（实际删除）
		targetFile.delete();
	}
	
	/**
	 * 修改article表的status属性（修改审核状态）
	 * @return
	 */
	@RequestMapping("/articleStatus")
	public String articleStatus(Article article) {
		
		articleService.updateArticleStatus(article);
		Message message = new Message();
		message.setFid(null);
		message.setUserid(article.getUserid());
		message.setTime(article.getTime());
		if(article.getStatus()==1)
		message.setMcontent("你的帖子标题为：" + article.getTitles() + "，管理员已经审核通过了！");
		else message.setMcontent("你的帖子帖子标题为：" + article.getTitles() + "，管理员审核未通过了！");
		message.setBeuserid(0);
		message.setStatus(0);
		messageService.setMessage(message);
		//审核成功发送消息给用户
		
		return "redirect:/admin/index.jsp";
	}
	
	/**
	 * 按fid查询帖子信息（帖子展示）
	 * @return
	 */
	@RequestMapping("/getArticleFid")
	public String getArticleFid(Map<Object, Object> map,HttpServletRequest request) {
		
		int fid=Integer.parseInt(request.getParameter("fid"));
//		Article article = articleService.getArticleKey(fid);
		map.put("article_Show",articleService.getArticleKey(fid));
//		System.out.println(fid);
//		System.out.println("帖子展示:"+articleService.getArticleKey(fid));
//		System.out.println(map.get("article_Show"));
		return "redirect:/content/articleShow.jsp";
	}

	
}
