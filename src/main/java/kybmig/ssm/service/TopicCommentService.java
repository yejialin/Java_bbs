package kybmig.ssm.service;


import kybmig.ssm.mapper.TopicCommentMapper;
import kybmig.ssm.mapper.TopicMapper;
import kybmig.ssm.model.TopicCommentModel;
import kybmig.ssm.model.TopicModel;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class TopicCommentService {
    private TopicMapper topicMapper;
    private TopicCommentMapper commentMapper;

    public TopicCommentService(TopicMapper TopicMapper, TopicCommentMapper commentMapper) {
        this.topicMapper = TopicMapper;
        this.commentMapper = commentMapper;
    }

    public TopicCommentModel add(String content, Integer topicId, Integer userId) {
        TopicCommentModel m = new TopicCommentModel();
        m.setUserId(userId);
        m.setContent(content);
        m.setTopicId(topicId);
        m.setCreatedTime(System.currentTimeMillis());
        m.setUpdatedTime(System.currentTimeMillis());
        commentMapper.insertTopicComment(m);
        return m;
    }


    public void update(Integer id, String content) {
        TopicCommentModel m = new TopicCommentModel();
        m.setId(id);
        m.setContent(content);
        m.setUpdatedTime(System.currentTimeMillis());
        commentMapper.updateTopicComment(m);
    }


    public void deleteById(Integer id) {
        commentMapper.deleteTopicComment(id);;
    }


    public TopicCommentModel findById(Integer id) {
        return commentMapper.selectTopicComment(id);
    }


    public List<TopicCommentModel> all() {
        return commentMapper.selectAllTopicComment();
    }

}
