package kybmig.ssm.service;


import kybmig.ssm.Utility;
import kybmig.ssm.mapper.TopicCommentMapper;
import kybmig.ssm.mapper.TopicMapper;
import kybmig.ssm.model.TopicCommentModel;
import kybmig.ssm.model.TopicModel;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class TopicService {
    private TopicMapper mapper;
    private TopicCommentMapper commentMapper;
    
    public TopicService(TopicMapper TopicMapper, TopicCommentMapper commentMapper) {
        this.mapper = TopicMapper;
        this.commentMapper = commentMapper;
    }

    public TopicModel add(String content, String title, Integer userId) {
        TopicModel m = new TopicModel();
        m.setUserId(userId);
        m.setTitle(title);;
        m.setContent(content);
        m.setCreatedTime(System.currentTimeMillis());
        m.setUpdatedTime(System.currentTimeMillis());
        mapper.insertTopic(m);
        return m;
    }


    public void update(Integer id, String content, String title) {
        TopicModel m = new TopicModel();
        m.setId(id);
        m.setContent(content);
        m.setTitle(title);
        m.setUpdatedTime(System.currentTimeMillis());
        mapper.updateTopic(m);
    }


    public void deleteById(Integer id) {
        mapper.deleteTopic(id);;
    }


    public TopicModel findById(Integer id) {
        return mapper.selectTopic(id);
    }


    public  List<TopicModel> all() {
        return mapper.selectAllTopic();
    }
    
    
    public List<TopicCommentModel> findAllComments(Integer id) {
        return this.commentMapper.selectAllTopicCommentByTopicId(id);
    }

    public TopicModel findByIdWithComments(Integer id) {
        return mapper.selectOneWithComments(id);
    }

    public List<TopicModel> getUserCreatedTopics(Integer userId) {
        return this.mapper.selectCreatedTopicWithUserId(userId);
    }

    public List<TopicModel> getUserJoinedTopics(Integer userId) {
        return this.mapper.selectJoinedTopicWithUserId(userId);
    }

    public List<TopicModel> getIndexTopics() {
        return this.mapper.getIndexTopics();
    }
    public void increaseViewCount(Integer id) {
        this.mapper.increaseViewCount(id);
    }
}
