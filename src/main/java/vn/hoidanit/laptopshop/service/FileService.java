package vn.hoidanit.laptopshop.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class FileService {
    private final ServletContext servletContext;

    public FileService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
        // getName() == "avatarFile" - variable name
        if (file.isEmpty())
            return "";
        String fileName = "";
        try {
            byte[] bytes = file.getBytes();
            // Servlet contenxt path pointing to webapp folder: "D:\IT\java\java
            // spring\hoidanit udemy\01-java-spring-laptopshop-starter\src\main\webapp\"
            // String servletContextPath = this.servletContext.getRealPath("");
            String rootPath = this.servletContext.getRealPath("/resources/images"); // absolute path

            // select or create avatar directory
            File dir = new File(rootPath + File.separator + targetFolder);
            if (!dir.exists())
                dir.mkdirs();

            // Create the file on server
            fileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + fileName); // add Milisecond time to
            // file name to avoid
            // duplicate file names.

            // copy (write) bytes of uploaded file to server file
            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));

            stream.write(bytes);
            stream.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return fileName;
    }

    public void deleteImageFile(String imgName, String folderName) {
        String folderPath = this.servletContext.getRealPath("/resources/images/") + folderName;
        File targetImg = new File(folderPath + File.separator + imgName);
        targetImg.delete();
    }

}
