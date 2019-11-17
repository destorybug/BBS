package com.liang.dao;

import java.util.List;

import com.liang.bean.Message;

public interface MessageMapper {

	//按mid删除消息
	int deleteByPrimaryKey(Integer mid);

    //删除该用户对应的所有信息(按userid)
    int deleteByUserid(int userid);
    
    //添加消息
    int insert(Message message);
    
    //按消息id（mid）查询详细消息，点击消息查看详细内容
    public Message selectByMessageMid(int mid);
    
    //按用户id（userid）查询评论表的fid信息，用于加载用户消息
    List<Message> selectByMessageUserid(int userid);


}
