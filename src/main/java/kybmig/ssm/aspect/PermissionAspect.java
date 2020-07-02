package kybmig.ssm.aspect;


import kybmig.ssm.Utility;
import kybmig.ssm.model.TopicModel;
import kybmig.ssm.model.UserModel;
import kybmig.ssm.model.UserRole;
import kybmig.ssm.service.TopicService;
import kybmig.ssm.service.UserService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Aspect
@Component
public class PermissionAspect {
    private UserService userService;
    private HttpServletRequest request;
    private TopicService topicService;

    public PermissionAspect(UserService service, HttpServletRequest request, TopicService topicService) {
        Utility.log("PermissionAspect 注入需要的依赖", request, service);
        this.request = request;
        this.userService = service;
        this.topicService = topicService;
    }

    @Around("execution(* kybmig.ssm.controller.TopicController.*(..))")
    public ModelAndView loginRequired(ProceedingJoinPoint joint) throws Throwable {
        Utility.log("loginRequired 正在访问的 url %s", request.getRequestURI());
        Utility.log("loginRequired 正在执行的方法 %s %s", joint.getSignature(), joint.getArgs());
        Integer userID = (Integer) request.getSession().getAttribute("user_id");
        if (userID == null) {
            // 跳转回登陆页面
            Utility.log("loginRequired 没有 session");
            return new ModelAndView("redirect:/login");
        } else {
            UserModel u = userService.findById(userID);
            if (u == null && u.getRole().equals(UserRole.guest)) {
                // 跳转回登陆页面
                Utility.log("loginRequired 用户不存在 %s", userID);
                return new ModelAndView("redirect:/login");
            } else {
                // 执行被插入的方法
                return (ModelAndView) joint.proceed();
            }
        }
    }

    @Around("execution(* kybmig.ssm.controller.TopicController.edit(..))")
    public ModelAndView owerRequired(ProceedingJoinPoint joint) throws Throwable {
        Utility.log("owerRequired 正在访问的 url %s", request.getRequestURI());
        Utility.log("owerRequired 正在执行的方法 %s %s", joint.getSignature(), joint.getArgs());
        Integer userID = (Integer) request.getSession().getAttribute("user_id");
        Integer topicId = Integer.valueOf(request.getParameter("id"));
        if (userID == null) {
            // 跳转回登陆页面
            Utility.log("loginRequired 没有 session");
            return new ModelAndView("redirect:/login");
        } else {
            UserModel u = userService.findById(userID);
            if (u == null && u.getRole().equals(UserRole.guest)) {
                // 跳转回登陆页面
                Utility.log("loginRequired 用户不存在 %s", userID);
                return new ModelAndView("redirect:/login");
            } else {
                // 执行被插入的方法
                TopicModel topic = topicService.findById(topicId);
                if (userID.equals(topic.getUserId())) {
                    return (ModelAndView) joint.proceed();
                } else {
                    return new ModelAndView("redirect:/login");
                }
            }
        }
    }


}
