package kybmig.ssm.service;


import kybmig.ssm.mapper.UserMapper;
import kybmig.ssm.model.UserModel;
import kybmig.ssm.model.UserRole;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;


@Service
public class UserService {
    private UserMapper mapper;

    public UserService(UserMapper userMapper) {
        this.mapper = userMapper;
    }

    public  UserModel add(String username, String password) {
        UserModel m = new UserModel();
        m.setUsername(username);
        m.setPassword(password);
        m.setRole(UserRole.normal);
        mapper.insertUser(m);

        return m;
    }

    
    public  boolean validLogin(String username, String password) {
        UserModel user = mapper.selectOneByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return true;
        }

        return false;
    }
    

    
    public  UserModel findByUsername(String username) {
        return mapper.selectOneByUsername(username);
    }
    
    public  UserModel findById(Integer id) {
        return mapper.selectOne(id);
    }
    public  UserModel guest() {
        UserModel g = new UserModel();
        g.setId(-1);
        g.setUsername("游客");
        g.setPassword("");
        g.setRole(UserRole.guest);
        return g;
    }

    public UserModel currentUser(HttpServletRequest request) {
        Integer userId = (Integer) request.getSession().getAttribute("user_id");
        if (userId == null) {
            return this.guest();
        }
        UserModel m = this.findById(userId);

        if (m == null) {
            return this.guest();
        }

        return m;
    }

    public void updatePassword(Integer id, String password) {
        UserModel m = new UserModel();
        m.setId(id);
        m.setPassword(password);
        mapper.updatePassword(m);
    }

    public void updateUser(Integer id, String email, String signture) {
        UserModel m = new UserModel();
        m.setId(id);
        m.setEmail(email);
        m.setSignature(signture);
        mapper.updateUser(m);
    }
}
