package com.revolvingSolutions.aicvgeneratorbackend.entitiy;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collection;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "cv")
public class CvEntity {

    @Id
    @GeneratedValue
    private Integer userid;

    private String fname;
    private String lname;
    private String email;
    private String cell;
    private String address;
    
    public void setName(String n) {
        fname = n;
    }

    public void setSurname(String sn) {
        lname = sn;
    }

    public void setEmail(String e) {
        email = e;
    }

    public void setCell(String c) {
        cell = c;
    }

    public void setAddress(String a) {
        address = a;
    }

    public String getName() {
        return fname;
    }

    public String getLastName() {
        return lname;
    }

    public String getCell() {
        return cell;
    }

    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }


}
