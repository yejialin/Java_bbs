package kybmig.ssm.controller;

import kybmig.ssm.Utility;
import kybmig.ssm.model.TopicCommentModel;
import kybmig.ssm.model.TopicModel;
import kybmig.ssm.model.UserModel;
import kybmig.ssm.service.TopicCommentService;
import kybmig.ssm.service.TopicService;
import kybmig.ssm.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/topic/{topicId}/comment")
public class TopicCommentController {

    private TopicCommentService topicCommentService;
    private UserService userService;

    public TopicCommentController(TopicCommentService topicCommentService, UserService userService) {
        this.topicCommentService = topicCommentService;
        this.userService = userService;
    }

    @PostMapping("/add")
    public ModelAndView add(@PathVariable Integer topicId, String content, HttpServletRequest request) {
        content = content.replace(">", "&gt");
        content = content.replace("<", "&lt");

        UserModel current = userService.currentUser(request);
        topicCommentService.add(content, topicId, current.getId());
        ModelAndView m = new ModelAndView(String.format("redirect:/topic/detail/%s", topicId));
        return m;
    }

    @PostMapping("/update")
    public ModelAndView update(@PathVariable Integer topicId, Integer id, String content) {
        Utility.log("content: %s", content);
        topicCommentService.update(id, content);
        ModelAndView m = new ModelAndView(String.format("redirect:/topic/detail/%s", topicId));
        return m;
    }


    @GetMapping("/delete")
    public ModelAndView delete(@PathVariable Integer topicId, Integer id, HttpServletRequest request) {
        UserModel user = userService.currentUser(request);
        topicCommentService.deleteById(id);
        ModelAndView m = new ModelAndView(String.format("redirect:/topic/detail/%s", topicId));
        return m;
    }

    @GetMapping("/edit")
    public ModelAndView edit(@PathVariable Integer topicId, Integer id, HttpServletRequest request) {
        UserModel current = userService.currentUser(request);
        TopicCommentModel comment = topicCommentService.findById(id);
        ModelAndView m = new ModelAndView("topic_comment_edit");
        m.addObject("comment", comment);
        m.addObject("currentUser", current);
        return m;
    }

}
