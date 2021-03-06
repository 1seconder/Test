package com.newenv.lpzd.security.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.catalina.realm.GenericPrincipal;
import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSON;
import com.newenv.base.action.impl.BaseAction;
import com.newenv.lpzd.base.service.XhjJccityService;
import com.newenv.lpzd.security.domain.TblUserLogin;
import com.newenv.lpzd.security.domain.TblUserProfile;
import com.newenv.lpzd.security.domain.UserLogin;
import com.newenv.lpzd.security.service.SecurityUserHolder;
import com.newenv.lpzd.security.service.SecurityUtil;
import com.newenv.lpzd.security.service.UserLoginService;
import com.newenv.lpzd.util.AppConstants;
import com.newenv.utils.NewenvCollectionUtil;

/**
 * This action will validate users information while they trying to login into
 * bms Administration Tool.
 * 
 * @author joe.li
 *
 */
public class LoginAction extends BaseAction {

	private UserLoginService userLoginService;

	private XhjJccityService xhjJccityService;

	private TblUserLogin userLogin;

	private String title; // 岗位

	/**
	 * Valid the user name and password.
	 */
	public String execute() throws Exception {

		/*
		 * String verifyCode =(String)
		 * this.getRequest().getParameter("verifyCode"); if
		 * (AppConstants.CHECK_VERIFY_CODE&&StringUtils.isEmpty(verifyCode) ) {
		 * super.setSessionAtt("verifyCodeWrong","验证码错误"); return "failure"; }
		 * else { String kaptchaValue = (String)
		 * ActionContext.getContext().getSession().get(Constants.
		 * KAPTCHA_SESSION_KEY); if
		 * (AppConstants.CHECK_VERIFY_CODE&&(kaptchaValue == null ||
		 * kaptchaValue == "" || !verifyCode.equalsIgnoreCase(kaptchaValue))) {
		 * super.setSessionAtt("verifyCodeWrong","验证码错误"); return "failure"; } }
		 */

		if (userLogin != null && StringUtils.isEmpty(userLogin.getUsername())) {
			this.getRequest().getRequestDispatcher("/login.jsp").forward(this.getRequest(), this.getResponse());
		}

		if (userLogin != null && StringUtils.isEmpty(userLogin.getPassword())) {
			this.getRequest().getRequestDispatcher("/login.jsp").forward(this.getRequest(), this.getResponse());
		}

		// if(!employeeList.get(0).getPassword().equals(NewenvCollectionUtil.md5Encode(request.getParameter("j_password")))){
		TblUserLogin user = userLoginService.login(userLogin.getUsername());
		if (user != null) {// 登录成功

			if (!user.getPassword().equals(NewenvCollectionUtil.md5Encode(userLogin.getPassword()))) {
				super.setSessionAtt("wrongpassword", "密码错误");
				return "failure";
			}

			TblUserProfile userProfile = userLoginService.findTblUserProfileById(user.getTblUserProfileId());

			UserLogin u = new UserLogin();
			u.setUserLogin(user);
			user.setIp(super.getRequest().getRemoteAddr());
			u.setUserProfile(userProfile);

			SecurityUserHolder.setCurrentUserLogin(u);
			this.getSession().setAttribute(AppConstants.CURRENT_USER, u);

			String[] titleInfo = title.split("\\.");
			userLoginService.setOrChangeTitle(title, Integer.valueOf(titleInfo[1]), Integer.valueOf(titleInfo[2]));

		} else {
			super.setSessionAtt("userInfoWrong", "用户名或密码错误");
			return "failure";
		}

		return SUCCESS;
	}

	public String setOrChangeTitle() {
		try {
			String[] titleInfo = title.split("\\.");
			userLoginService.setOrChangeTitle(title, Integer.valueOf(titleInfo[1]), Integer.valueOf(titleInfo[2]));
		} catch (Exception e) {

		}
		return this.jsonAjaxSuccessResult("");
	}

	public String login() throws Exception {
		return SUCCESS;
	}

	public String findAllTitleNamesByUsername() {

		List<Object[]> findAllTitleNamesByUsername = userLoginService
				.findAllTitleNamesByUsername(userLogin.getUsername());
		return jsonAjaxResult(JSON.toJSONString(findAllTitleNamesByUsername));
	}

	public void setUserLoginService(UserLoginService userLoginService) {
		this.userLoginService = userLoginService;
	}

	public String loginOut() {
		// 清空人员和权限
		super.removeSessionAtt(AppConstants.CURRENT_USER);
		super.removeSessionAtt(AppConstants.SYNCHRONIZE_PERMISSION);
		SecurityUtil.resetHRPermissions();// 清空
		return SUCCESS;
	}

	/**
	 * sso
	 * 
	 * @return
	 */
	public String ssoLogin() throws Exception {
		// 判断是否登录
		if (getRequest().getUserPrincipal() == null) {
			// 没有用户信息
			return "failure";
		}
		String[] roles = ((GenericPrincipal) (getRequest()).getUserPrincipal()).getRoles();
		if (roles == null) {
			// 没有角色信息
			return "failure";
		}
		TblUserLogin user = userLoginService.login(getRequest().getUserPrincipal().getName());
		if (user != null) {// 登录成功

			TblUserProfile userProfile = userLoginService.findTblUserProfileById(user.getTblUserProfileId());

			UserLogin u = new UserLogin();
			u.setUserLogin(user);
			user.setIp(super.getRequest().getRemoteAddr());
			u.setUserProfile(userProfile);
			SecurityUserHolder.setCurrentUserLogin(u);
			this.getSession().setAttribute(AppConstants.CURRENT_USER, u);

			userLoginService.setOrChangeTitle(title, userProfile.getTblDepartmentId(), userProfile.getTblTitle());
			return SUCCESS;
		} else {
			super.setSessionAtt("userInfoWrong", "用户名或密码错误");
			// 登录不成功
			return "failure";
		}
	}

	public TblUserLogin getUserLogin() {
		return userLogin;
	}

	public void setUserLogin(TblUserLogin userLogin) {
		this.userLogin = userLogin;
	}

	public XhjJccityService getXhjJccityService() {
		return xhjJccityService;
	}

	public void setXhjJccityService(XhjJccityService xhjJccityService) {
		this.xhjJccityService = xhjJccityService;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
