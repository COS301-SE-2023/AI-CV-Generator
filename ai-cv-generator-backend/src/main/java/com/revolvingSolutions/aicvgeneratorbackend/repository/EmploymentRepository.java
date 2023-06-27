package com.revolvingSolutions.aicvgeneratorbackend.repository;

import com.revolvingSolutions.aicvgeneratorbackend.entitiy.EmploymentEntity;
import com.revolvingSolutions.aicvgeneratorbackend.model.Employment;
import com.revolvingSolutions.aicvgeneratorbackend.model.FileModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface EmploymentRepository extends JpaRepository<EmploymentEntity,Integer> {
    @Query("SELECT new com.revolvingSolutions.aicvgeneratorbackend.model.Employment(f.empid,f.company,f.title,f.startdate,f.enddate) FROM EmploymentEntity f WHERE f.user.username = ?1")
    public List<Employment> getEmploymentHistoryFromUser(String username);
}
