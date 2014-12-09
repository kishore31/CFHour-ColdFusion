component client="true" output="false"
{	
	
	public any function init()
	{
		clearDatasource(); // TODO: This is just in for testing.
		createDatasource();
		return this;
	}
		
	private any function clearDatasource()
	{
		var q = '';
		var sql = 'drop table shows';
		q = queryExecute(sql, null, {"datasource"="cfhour_db"});
	}
	
	public function getAllPlaceTypes() hint="I return all place types from the datasource." output="false"
	{
		var q = '';
		var sql = 'select * from shows order by label ASC';
		q = queryExecute(sql, null, {"datasource"="cfhour_db"});
		return q;
	}

	private any function createDatasource() hint="I create the datasource." output="false"
	{
		var q = '';
		var sql = "create table if not exists shows (
							id integer primary key autoincrement,
							title text,
							id text,
							played text,
							marker integer
					)";
		q = queryExecute(sql, null, {"datasource"="cfhour_db"});
	}
	
	private any function checkdb() {
		q = queryExecute("select * from shows", null, {"datasource"="cfhour_db"});
		return q;
	}

}