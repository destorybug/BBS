package com.liang.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.liang.bean.Admin;
import com.liang.bean.User;
import com.liang.service.AdminService;

@Controller
@RequestMapping("adminController")
@SessionAttributes(value="adminList")
public class AdminController {

	@Autowired
	AdminService adminService;
	@Autowired
	PlateController plateController;
	@Autowired
	UserController userController;
	
	List<Admin> list=new ArrayList<>();
	
	/**
	 * 绠＄悊鍛樼櫥褰曞垽鏂�
	 * @param admin
	 * @param map
	 * @return
	 */
	@RequestMapping("getLogin")
	public String getLogin(Admin admin, Map<Object, Object> map) {

		System.out.println(admin);
		
		//璋冪敤绠＄悊鍛樻煡璇㈡柟娉�
		list=adminService.getAdmin(admin);
		String str=list.toString();
		
		System.out.println(list);

		if (!str.equals("[]")) {

			map.put("adminList", list.get(0));
			plateController.getPlate(map);
			userController.getUser(map);
			
			return "redirect:/admin/index.jsp";//閲嶅畾鍚� 
		} else {

			return "redirect:/admin/index.jsp";//閲嶅畾鍚� 
		}
	}
	
	/**
	 * 绠＄悊鍛樻敞鍐�
	 * @param admin
	 * @param map
	 * @return
	 */
	@RequestMapping("/setSignUp")
	public String setSignUp(Admin admin, Map<Object, Object> map) {
		
		if(adminService.getAdminName(admin).toString().equals("[]")) {
			
			//璋冪敤绠＄悊鍛樻彃鍏ユ柟娉�
			adminService.setAdmin(admin);
			
			//璋冪敤绠＄悊鍛樻煡璇㈡柟娉曪紙鑾峰彇鍒氬垰娉ㄥ唽鐨勭鐞嗗憳淇℃伅锛�
			list=adminService.getAdmin(admin);
			
			map.put("adminList", list.get(0));
			
			System.out.println("绠＄悊鍛樻敞鍐屾垚鍔�");
			
			return "admin";
		}else {
			
			System.err.println("绠＄悊鍛樻敞鍐屽け璐�");
			return "redirect:/admin/index.jsp";//閲嶅畾鍚� 
		}
			
	}
	
	/**
	 * 閫�鍑虹鐞嗗憳鐧诲綍
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/adminExit")
	public String adminExit(Map<Object, Object> map) {

		map.put("adminList", "");
		return "redirect:/admin/index.jsp";// 閲嶅畾鍚�
	}
	
	
	
	
}
