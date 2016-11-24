package database;

import com.mongodb.AggregationOutput;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

public class MongoDbUtil implements DatabaseConstants{
	public static DBCollection myReviews;
	public static DBCollection Comments;
	public static MongoClient mongo;
	public static void getConnection()
	{
		
		mongo = new MongoClient("localhost", 27017);
		DB db = mongo.getDB("IllinoisTech");
		myReviews= db.getCollection("myReviews");
	}
	
	
	public static AggregationOutput query1(){

		getConnection();
		DBObject groupFields = new BasicDBObject("_id", "$productName");
		groupFields.put("rating",new BasicDBObject("$max","$rating"));
		DBObject group = new BasicDBObject("$group",groupFields);
		DBObject sort =  new BasicDBObject();
		sort.put("rating",-1);
		DBObject limit=new BasicDBObject();
		DBObject orderby=new BasicDBObject();
		orderby = new BasicDBObject("$sort",sort);
		limit = new BasicDBObject("$limit",5);
		AggregationOutput aggregate = myReviews.aggregate(group,orderby,limit);
		for (DBObject result : aggregate.results()) {
			BasicDBObject bobj = (BasicDBObject) result;
			System.out.println(bobj.getString("_id"));
			System.out.println(bobj.getString("rating"));
			}

	return aggregate;
	}
	
	
}
