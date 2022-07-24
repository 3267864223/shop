package com.jdbc;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import java.util.*;
import javax.sql.DataSource;
import java.sql.*;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.*;

public class DBUtil {

	private DBUtil() {
	}

	private static DataSource dataSource;

	static {
		dataSource = new ComboPooledDataSource("mysql");
	}

	/**
	 * 万能更新
	 * 
	 * @param sql    sql语句
	 * @param params 传过来的参数
	 * @return 受影响的行数
	 */
	public static int update(String sql, Object... params) {
		Connection conn = null;
		QueryRunner qr = null;
		try {
			conn = DBUtil.getConn();
			qr = new QueryRunner();
			return qr.update(conn, sql, params);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DBUtil.close(conn);
		}
	}

	/**
	 * 万能查询,查询一个对象
	 */
	public static <T> T getSingleObj(String sql, Class<T> clazz, Object... params) {
		Connection conn = null;
		QueryRunner qr = null;
		try {
			conn = DBUtil.getConn();
			qr = new QueryRunner();
			return qr.query(conn, sql, new BeanHandler<T>(clazz), params);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DBUtil.close(conn);
		}

	}

	/**
	 * 万能查询,查询一组对象
	 */
	public static <T> List<T> getList(String sql, Class<T> clazz, Object... params) {
		Connection conn = null;
		QueryRunner qr = null;
		try {
			conn = DBUtil.getConn();
			qr = new QueryRunner();
			return qr.query(conn, sql, new BeanListHandler<T>(clazz), params);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DBUtil.close(conn);
		}

	}

	/**
	 * 返回单个数据
	 * 
	 * @param sql
	 * @param params
	 * @return 单个数据
	 */
	public static <T> T getScalar(String sql, Object... params) {
		Connection conn = null;

		try {
			conn = DBUtil.getConn();
			return new QueryRunner().query(conn, sql, new ScalarHandler<T>(), params);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DBUtil.close(conn);
		}
	}

	/**
	 * 返回某列数据
	 * 
	 * @param sql
	 * @param params
	 * @return 某列数据的列表
	 */
	public static <T> List<T> getColumn(String sql, Object... params) {
		Connection conn = null;
		try {
			conn = DBUtil.getConn();
			return new QueryRunner().query(conn, sql, new ColumnListHandler<T>(), params);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DBUtil.close(conn);
		}
	}

	/**
	 * 把一条数据，以map集合的方式返回
	 * 
	 * @param sql
	 * @param params
	 * @return map集合
	 */
	public static Map<String, Object> getMap(String sql, Object... params) {
		Connection conn = null;
		try {
			conn = DBUtil.getConn();
			return new QueryRunner().query(conn, sql, new MapHandler(), params);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DBUtil.close(conn);
		}
	}

	/**
	 * 返回一个列表，列表中每条数据都是一个map集合
	 * 
	 * @param sql
	 * @param params
	 * @return
	 */
	public static List<Map<String, Object>> getMapList(String sql, Object... params) {
		Connection conn = null;
		try {
			conn = DBUtil.getConn();
			return new QueryRunner().query(conn, sql, new MapListHandler(), params);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DBUtil.close(conn);
		}
	}

	/**
	 * 添加完数据以后,把自增主键返回
	 * 
	 * @param sql
	 * @param params
	 * @return 生成的自增主键
	 */
	public static int addAndReturnId(String sql, Object... params) {
		Connection conn = null;
		PreparedStatement stm = null;

		try {
			conn = DBUtil.getConn();
			stm = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			for (int i = 0; i < params.length; i++) {
				stm.setObject(i + 1, params[i]);
			}

			stm.execute();
			ResultSet rsKey = stm.getGeneratedKeys();
			rsKey.next();
			return rsKey.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DBUtil.close(null, stm, conn);
		}
	}

	public static Connection getConn() {
		try {
			Connection conn = dataSource.getConnection();
			return conn;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void close(ResultSet rs, Statement stm, Connection conn) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (stm != null) {
			try {
				stm.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
