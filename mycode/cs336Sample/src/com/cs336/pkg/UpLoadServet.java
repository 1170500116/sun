package com.cs336.pkg; 
  import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Calendar; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
 
/**
 * Servlet implementation class UpLoadServet
 */
public class UpLoadServet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpLoadServet() {
        super();
        // TODO Auto-generated constructor stub
    }
 
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		boolean isMultipart=ServletFileUpload.isMultipartContent(request);
		if(isMultipart)
		{
			FileItemFactory factory=new DiskFileItemFactory();
			ServletFileUpload upload=new ServletFileUpload(factory);
			try {
				List<FileItem> items=upload.parseRequest(request);
				Iterator<FileItem> it = items.iterator();
				while(it.hasNext())
				{
					FileItem item = it.next();
					String itemname = item.getFieldName();
					int sno=-1;
					String sname=null;
					
					if(item.isFormField())
					{
						if(itemname.equals("sno"))
						{
							sno=Integer.parseInt(item.getString("utf-8"));
						}else if(itemname.equals("sname"))
						{
							sname=item.getString("utf-8");
							sname=item.getName();
						}else
						{
							System.out.println("others");
						}
					}else
					{
						String filename=(new File(item.getName())).getName();
						if(filename==null||filename.equals("")) {
							request.setAttribute("news", "image not found");
							
							request.getRequestDispatcher("print.jsp").forward(request, response);
						
							return;
						}
						String path=System.getProperty("user.dir")+File.separator+"images"+File.separator+"upload";
						String realFilePath = createRealFilePath(path, filename);
						File file=new File(realFilePath);
						
						item.write(file);
						request.setAttribute("realFilePath", file.getAbsolutePath());
						request.setAttribute("news", "image '"+filename+"' upload sucess!");
						System.out.println("here!!!!!!!!1");
						request.getRequestDispatcher("Release_aution.jsp").forward(request, response);
						
						return;
					}
					
				}
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
 
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private String createRealFilePath(String basePath, String fileName) {
		Calendar today = Calendar.getInstance(); 
		String year = String.valueOf(today.get(Calendar.YEAR));
		String month = String.valueOf(today.get(Calendar.MONTH) + 1); 
		String upPath = basePath + File.separator + year + File.separator + month + File.separator; 
		File uploadFolder = new File(upPath); 
		if (!uploadFolder.exists()) { 
			uploadFolder.mkdirs(); 
		}
		String realFilePath = upPath + fileName; 
		return realFilePath; 
		
	}

}