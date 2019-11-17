package com.liang.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.liang.bean.Message;
import com.liang.dao.MessageMapper;

@Service
public class MessageService {

	@Autowired
	MessageMapper messageMapper;
	
	//按mid删除消息
	public void deleteMessage(Integer mid) {
			
		messageMapper.deleteByPrimaryKey(mid);
	}
	
	
	//删除该用户对应的所有信息(按userid)
	public void deleteMessageUserid(int userid) {
    	
    	messageMapper.deleteByUserid(userid);
    }
	
    
  //添加消息
    public void setMessage(Message message) {
    	
    	messageMapper.insert(message);
    }
    
    
    //按消息id（mid）查询详细消息，点击消息查看详细内容
    public Message getMessageMid(int mid) {
    	return messageMapper.selectByMessageMid(mid);
    }
    
    ////按用户id（userid）查询评论表的fid信息，用于加载用户消息
    public List<Message> getMessage(int userid) {
    	return messageMapper.selectByMessageUserid(userid);
    }
}
