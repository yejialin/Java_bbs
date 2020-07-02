package kybmig.ssm.mapper;

import kybmig.ssm.model.UserModel;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface UserMapper {
    void insertUser(UserModel user);

    List<UserModel> selectAllUser();

    UserModel selectOne(int id);
    
    UserModel selectOneByUsername(String username);

    void updateUser(UserModel user);

    void deleteUser(int id);

    void updatePassword(UserModel user);
}
