package com.revolvingSolutions.aicvgeneratorbackend;

public class CV {

    String cv_id;
    //File cv_inputFile;
    boolean success;

    private String fname;
    private String lname;
    private String email;
    private String cell;
    private String address;

    private String institution1;
    private String institution2;
    private String qualification1;
    private String qualification2;
    private String dateObtained1;
    private String dateObtained2;

    private String company1;
    private String company2;
    private String jobTitle1;
    private String jobTitle2;
    private String duration1;
    private String duration2;

    private String skill1;
    private String skill2;
    private String skill3;

    private String refName1;
    private String refName2;
    private String refRelationship1;
    private String refRelationship2;
    private String refContact1;
    private String refContact2;

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCell() {
        return cell;
    }

    public void setCell(String cell) {
        this.cell = cell;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getInstitution1() {
        return institution1;
    }

    public void setInstitution1(String institution1) {
        this.institution1 = institution1;
    }

    public String getInstitution2() {
        return institution2;
    }

    public void setInstitution2(String institution2) {
        this.institution2 = institution2;
    }

    public String getQualification1() {
        return qualification1;
    }

    public void setQualification1(String qualification1) {
        this.qualification1 = qualification1;
    }

    public String getQualification2() {
        return qualification2;
    }

    public void setQualification2(String qualification2) {
        this.qualification2 = qualification2;
    }

    public String getDateObtained1() {
        return dateObtained1;
    }

    public void setDateObtained1(String dateObtained1) {
        this.dateObtained1 = dateObtained1;
    }

    public String getDateObtained2() {
        return dateObtained2;
    }

    public void setDateObtained2(String dateObtained2) {
        this.dateObtained2 = dateObtained2;
    }

    public String getCompany1() {
        return company1;
    }

    public void setCompany1(String company1) {
        this.company1 = company1;
    }

    public String getCompany2() {
        return company2;
    }

    public void setCompany2(String company2) {
        this.company2 = company2;
    }

    public String getJobTitle1() {
        return jobTitle1;
    }

    public void setJobTitle1(String jobTitle1) {
        this.jobTitle1 = jobTitle1;
    }

    public String getJobTitle2() {
        return jobTitle2;
    }

    public void setJobTitle2(String jobTitle2) {
        this.jobTitle2 = jobTitle2;
    }

    public String getDuration1() {
        return duration1;
    }

    public void setDuration1(String duration1) {
        this.duration1 = duration1;
    }

    public String getDuration2() {
        return duration2;
    }

    public void setDuration2(String duration2) {
        this.duration2 = duration2;
    }

    public String getSkill1() {
        return skill1;
    }

    public void setSkill1(String skill1) {
        this.skill1 = skill1;
    }

    public String getSkill2() {
        return skill2;
    }

    public void setSkill2(String skill2) {
        this.skill2 = skill2;
    }

    public String getSkill3() {
        return skill3;
    }

    public void setSkill3(String skill3) {
        this.skill3 = skill3;
    }

    public String getRefName1() {
        return refName1;
    }

    public void setRefName1(String refName1) {
        this.refName1 = refName1;
    }

    public String getRefName2() {
        return refName2;
    }

    public void setRefName2(String refName2) {
        this.refName2 = refName2;
    }

    public String getRefRelationship1() {
        return refRelationship1;
    }

    public void setRefRelationship1(String refRelationship1) {
        this.refRelationship1 = refRelationship1;
    }

    public String getRefRelationship2() {
        return refRelationship2;
    }

    public void setRefRelationship2(String refRelationship2) {
        this.refRelationship2 = refRelationship2;
    }

    public String getRefContact1() {
        return refContact1;
    }

    public void setRefContact1(String refContact1) {
        this.refContact1 = refContact1;
    }

    public String getRefContact2() {
        return refContact2;
    }

    public void setRefContact2(String refContact2) {
        this.refContact2 = refContact2;
    }

    public CV()
    {
        success = false;
    }

    public void addPersonalDetails(String fname, String lname, String email, String cell, String address)
    {
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.cell = cell;
        this.address = address;
    }


    public void addQualification1(String institution1, String qualification1, String dateObtained1)
    {
        this.institution1 = institution1;
        this.qualification1 = qualification1;
        this.dateObtained1 = dateObtained1;
    }
    public void addQualification2(String institution2, String qualification2, String dateObtained2)
    {
        this.institution2 = institution2;
        this.qualification2 = qualification2;
        this.dateObtained2 = dateObtained2;
    }

    public void addEmployment1(String company1, String jobTitle1, String duration1)
    {
        this.company1 = company1;
        this.jobTitle1 = jobTitle1;
        this.duration1 = duration1;
    }
    public void addEmployment2(String company2, String jobTitle2, String duration2)
    {
        this.company2 = company2;
        this.jobTitle2 = jobTitle2;
        this.duration2 = duration2;
    }

    public void addSkill1(String skill1)
    {
        this.skill1 = skill1;
    }
    public void addSkill2(String skill2)
    {
        this.skill2 = skill2;
    }
    public void addSkill3(String skill3)
    {
        this.skill3 = skill3;
    }


    public void addReference1(String name1, String relationship1, String contact1)
    {
        this.refName1 = name1;
        this.refRelationship1 = relationship1;
        this.refContact1 = contact1;
    }
    public void addReference2(String name2, String relationship2, String contact2)
    {
        this.refName2 = name2;
        this.refRelationship2 = relationship2;
        this.refContact2 = contact2;
    }

    

    public boolean createCV(String userId)
    {
        cv_id = userId;
        //cv_inputFile = file
        success = true;
        return success;
    }
    
}   

