package database;

import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.MongoClient;

public class MongoDbUtil implements DatabaseConstants{
	public static DBCollection myReviews;
	public static void getConnection()
	{
		MongoClient mongo;
		mongo = new MongoClient("localhost", 27017);
		DB db = mongo.getDB("IllinoisTech");
		myReviews= db.getCollection("myReviews");
	}
}
