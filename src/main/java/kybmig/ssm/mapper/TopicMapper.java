package kybmig.ssm.mapper;

import kybmig.ssm.model.TopicModel;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface TopicMapper {
    void insertTopic(TopicModel topic);

    List<TopicModel> selectAllTopic();

    TopicModel selectTopic(int id);

    void updateTopic(TopicModel topic);

    void deleteTopic(int id);
    
    TopicModel selectOneWithComments(Integer id);

    List<TopicModel> selectCreatedTopicWithUserId(int UserId);

    List<TopicModel> selectJoinedTopicWithUserId(int UserId);

    List<TopicModel> getIndexTopics();

    void increaseViewCount(int id);
}
