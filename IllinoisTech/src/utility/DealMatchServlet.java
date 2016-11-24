package utility;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.MySqlJDBC;
import bean.Products;

@WebServlet("/DealMatchServlet")
public class DealMatchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public DealMatchServlet() {
        super();
        
    }

	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		MySqlJDBC mysql = new MySqlJDBC();
		HashMap<String, Products> allProducts = new HashMap<String, Products>();
		HashMap<String, Products> productsToDisplay = new HashMap<String, Products>();
		String tweetsToDisplay = "";
		allProducts = mysql.getProductList();
		List<String> keys = new ArrayList<String>(allProducts.keySet());
		Collections.shuffle(keys);
		request.getSession().setAttribute("ProductMap", allProducts);
		Products prod = new Products();
		System.out.println("In deal match");
		
		
		//Get all Tweets from 'DealMatch.txt' that we got from twitter which matched our products.
		try{
			String line="";
			String productName = "";
			
			for(String i : keys){
				
				if(productsToDisplay.size()<2 && !productsToDisplay.containsKey(i)){
					BufferedReader tweets = new BufferedReader(new FileReader(new File("C:/Users/acdes/git/CSP-595-Final-Project/IllinoisTech/DealMatches.txt")));
					line = tweets.readLine();
					productName = allProducts.get(i).getProductName();
					
					if(line==null){
						tweetsToDisplay = "No Offers Found.";
						break;
					}else{
						do{
							if(line.contains(productName)){
								tweetsToDisplay = tweetsToDisplay + line +"<br></br>";
								productsToDisplay.put(i, allProducts.get(i));
								System.out.println("Deal match:" + line + "\n" + productName);
								break;
							}
						}while((line=tweets.readLine())!=null);
					}
				}
				
			}
			request.getSession().setAttribute("tweets", tweetsToDisplay);
			request.getSession().setAttribute("products", productsToDisplay);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
