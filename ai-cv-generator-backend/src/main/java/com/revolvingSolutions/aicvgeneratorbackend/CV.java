package com.revolvingSolutions.aicvgeneratorbackend;

public class CV {

    String cv_id;
    //File cv_inputFile;
    boolean success = false;

    public boolean CreateCV(String userId, /*File file */)
    {
        cv_id = userId;
        //cv_inputFile = file
        success = true;
        return success;
    }
    
}
