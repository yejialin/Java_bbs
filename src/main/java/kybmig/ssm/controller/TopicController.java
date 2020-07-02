package kybmig.ssm.controller;

import kybmig.ssm.Utility;
import kybmig.ssm.model.TopicCommentModel;
import kybmig.ssm.model.TopicModel;
import kybmig.ssm.model.UserModel;
import kybmig.ssm.model.UserRole;
import kybmig.ssm.service.TopicService;
import kybmig.ssm.service.UserService;
import org.springframework.boot.autoconfigure.security.SecurityProperties;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Controller
public class TopicController {

    private TopicService topicService;
    private UserService userService;
    private HashMap<String, String> tokenMap = new HashMap<>();

    public TopicController(TopicService topicService, UserService userService) {
        this.topicService = topicService;
        this.userService = userService;
    }

    @GetMapping("/topic/add")
    public ModelAndView addIndex(HttpServletRequest request) {
        UserModel currentUser = userService.currentUser(request);
        ModelAndView m = new ModelAndView("topic_add");
        m.addObject("currentUser", currentUser);
        return m;
    }

    @PostMapping("/topic/add")
    public ModelAndView add(String content, String title, HttpServletRequest request) {
        content = content.replace(">", "&gt");
        content = content.replace("<", "&lt");

        title = title.replace(">", "&gt");
        title = title.replace("<", "&lt");

        UserModel current = userService.currentUser(request);
        topicService.add(content, title, current.getId());
        ModelAndView m = new ModelAndView(String.format("redirect:/user/%s", current.getUsername()));
        return m;

    }

    @PostMapping("/topic/update")
    public ModelAndView update(Integer id, String content, String title) {
        Utility.log("content: %s", content);
        topicService.update(id, content, title);
        ModelAndView m = new ModelAndView(String.format("redirect:/topic/detail/%s", id));
        return m;
    }


    @GetMapping("/topic/delete")
    public ModelAndView delete(Integer id, HttpServletRequest request) {
        UserModel user = userService.currentUser(request);
        String token = request.getParameter("token");
        String userToken = tokenMap.get(user.getId().toString());

        if (userToken.equals(token)) {
            topicService.deleteById(id);
            ModelAndView m = new ModelAndView("redirect:/topic");
            return m;
        } else {
            ModelAndView m = new ModelAndView("redirect:/login");
            return m;
        }
    }


    @GetMapping("/topic/edit")
    public ModelAndView edit(Integer id, HttpServletRequest request) {
        UserModel user = userService.currentUser(request);
        TopicModel topic = topicService.findById(id);
        ModelAndView m = new ModelAndView("topic_edit");
        m.addObject("topic", topic);
        m.addObject("currentUser", user);
        return m;
    }

    @GetMapping("/topic/detail/{id}")
    public ModelAndView detail(@PathVariable Integer id, HttpServletRequest request) {
        String token = UUID.randomUUID().toString();
        UserModel user = userService.currentUser(request);
        tokenMap.put(user.getId().toString(), token);
        TopicModel topic = topicService.findByIdWithComments(id);
        Utility.log("topic: %s", topic);
        List<TopicCommentModel> comments = topicService.findAllComments(topic.getId());
        ModelAndView m = new ModelAndView("topic_detail");
        m.addObject("topic", topic);
        m.addObject("comments", comments);
        m.addObject("token", token);
        m.addObject("currentUser", user);
        topicService.increaseViewCount(topic.getId());
        return m;
    }
    
}
