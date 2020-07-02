package kybmig.ssm.controller;

import com.sun.mail.imap.protocol.MODSEQ;
import kybmig.ssm.Utility;
import kybmig.ssm.model.TopicModel;
import kybmig.ssm.model.UserModel;
import kybmig.ssm.model.UserRole;
import kybmig.ssm.service.TopicService;
import kybmig.ssm.service.UserService;
import org.apache.catalina.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Controller
public class UserController {
    private UserService userService;
    private HashMap<String, Integer> resetMap = new HashMap<>();
    private AsyncTask asyncTask;
    private TopicService topicService;

    public UserController(UserService userService, AsyncTask asyncTask, TopicService topicService) {
        this.userService = userService;
        this.asyncTask = asyncTask;
        this.topicService = topicService;
    }

    @GetMapping("/")
    public ModelAndView indexView(HttpServletRequest request) {
        List<TopicModel> topics = topicService.getIndexTopics();
        UserModel currentUser = userService.currentUser(request);
        if (currentUser.getRole().equals(UserRole.guest)) {
            return new ModelAndView("user/login");
        } else {
            ModelAndView m = new ModelAndView("index");
            m.addObject("currentUser", currentUser);
            m.addObject("topics", topics);
            return m;
        }
    }


    @GetMapping("/login")
    public ModelAndView loginView() {
        ModelAndView m = new ModelAndView("user/login");
        return m;
    }

    @GetMapping("/user/setting")
    public ModelAndView UserSetting( HttpServletRequest request) {
        UserModel user = userService.currentUser(request);
        ModelAndView m = new ModelAndView("user/setting");
        m.addObject("user", user);
        return m;
    }

    @PostMapping("/user/update")
    public ModelAndView updateUserSetting(HttpServletRequest request) {
        UserModel user = userService.currentUser(request);
        String email = request.getParameter("email");
        String signature = request.getParameter("signature");
        String oldPass = request.getParameter("old_pass");
        String newPass = request.getParameter("new_pass");
        if (email != null || newPass != signature) {
            userService.updateUser(user.getId(), email, signature);
        }
        if (oldPass != null && newPass != null) {
            if (userService.validLogin(user.getUsername(), oldPass)) {
                userService.updatePassword(user.getId(), newPass);
            }
        }
        return new ModelAndView("redirect:/user/setting");
    }

    @GetMapping("/user/{username}")
    public ModelAndView UserPage(@PathVariable String username, HttpServletRequest request) {
        UserModel currentUser = userService.currentUser(request);
        UserModel user = userService.findByUsername(username);
        if (user==null) {
            return new ModelAndView("redirect:/login");
        }
        ModelAndView m = new ModelAndView("user/user_page");
        List<TopicModel> createdTopics = topicService.getUserCreatedTopics(user.getId());
        List<TopicModel> joinedTopics = topicService.getUserJoinedTopics(user.getId());
        m.addObject("user", user);
        m.addObject("currentUser", currentUser);
        m.addObject("recent_create_topics", createdTopics);
        m.addObject("recent_join_topics", joinedTopics);
        return m;
    }

    @PostMapping("/user/login")
    public String login(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserModel user = userService.findByUsername(username);
        if (userService.validLogin(username, password)) {
            request.getSession().setAttribute("user_id", user.getId());
            return "redirect:/";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/register")
    public ModelAndView registerView() {
        ModelAndView m = new ModelAndView("user/register");
        return m;
    }


    @PostMapping("/user/register")
    public String register(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserModel user = userService.findByUsername(username);
        userService.add(username, password);
        return "redirect:/login";
    }

    @GetMapping("/reset/view")
    public ModelAndView resetView(HttpServletRequest request) {
        String token = request.getParameter("token");
        Integer user_id = resetMap.get(token);
        if (user_id != null) {
            ModelAndView m = new ModelAndView("reset_view");
            m.addObject("token", token);
            return m;
        } else {
            return new ModelAndView("redirect:/login");
        }
    }

    @PostMapping("/reset/send")
    public ModelAndView resetSend(HttpServletRequest request) {
        String username = request.getParameter("username");
        UserModel user = userService.findByUsername(username);
        String token = UUID.randomUUID().toString();
        resetMap.put(token, user.getId());
        if (user.getEmail() != null) {
            asyncTask.sendMail(user.getEmail(), "密码重置确认",
                    String.format("请复制访问请求完成重置, http://106.54.164.16/reset/view?token=%s", token)
            );
            return new ModelAndView("reset_send");
        } else {
            return new ModelAndView("redirect:/login");
        }
    }

    @GetMapping("/reset/index")
    public ModelAndView resetIndex(HttpServletRequest request) {
        ModelAndView m = new ModelAndView("reset_index");
        return m;
    }

    @PostMapping("/reset/update")
    public ModelAndView resetUpdate(HttpServletRequest request) {
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        Integer user_id = resetMap.get(token);
        UserModel user = userService.findById(user_id);
        if (user != null) {
            userService.updatePassword(user_id, password);
        }
        return new ModelAndView("redirect:/login");
    }
}
