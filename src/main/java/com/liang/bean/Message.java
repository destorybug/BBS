package com.liang.bean;

public class Message {

	private Integer mid;
	
	private String mcontent;

	//接受消息人id
    private Integer userid;
    
    //发送消息人id
    private Integer beuserid;

    //发送消息时间
    private String time;

    private Integer status;
    
    private Integer fid;
    
	public Message() {
		super();
	}

	public Message(Integer mid, String mcontent, Integer userid, Integer beuserid, String time, Integer status,
			Integer fid) {
		super();
		this.mid = mid;
		this.mcontent = mcontent;
		this.userid = userid;
		this.beuserid = beuserid;
		this.time = time;
		this.status = status;
		this.fid = fid;
	}

	public Integer getMid() {
		return mid;
	}

	public void setMid(Integer mid) {
		this.mid = mid;
	}

	public String getMcontent() {
		return mcontent;
	}

	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public Integer getBeuserid() {
		return beuserid;
	}

	public void setBeuserid(Integer beuserid) {
		this.beuserid = beuserid;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getFid() {
		return fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	@Override
	public String toString() {
		return "Message [mid=" + mid + ", mcontent=" + mcontent + ", userid=" + userid + ", beuserid=" + beuserid
				+ ", time=" + time + ", status=" + status + ", fid=" + fid + "]";
	}
    
	
}
