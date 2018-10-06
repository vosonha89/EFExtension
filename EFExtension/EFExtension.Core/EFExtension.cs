using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;

namespace EFExtension.Core
{
    /// <summary>
    /// Extension for entity framework in .NET Framework. Helping developers are easy to use EF6.0 to call store procedure, view, function in SQL Server
    /// </summary>
    public static class EFExtension
    {
        /// <summary>
        /// This method help to execute store procedure by store name and simple sql param
        /// </summary>
        /// <typeparam name="T">Object type return</typeparam>
        /// <param name="context">Database context</param>
        /// <param name="storeName">Store name for execution</param>
        /// <param name="parameters">Array of parameters</param>
        /// <returns>List result set after mapping</returns>
        public static List<T> ExcuteStoreProcedure<T>(this DbContext context, string storeName, params SimpleSqlParam[] parameters) where T : class, new()
        {
            string query = storeName;
            List<SqlParameter> sqlParameters = new List<SqlParameter>();
            foreach (SimpleSqlParam param in parameters)
            {
                SqlParameter sqlParameter = new SqlParameter
                {
                    ParameterName = param.Name,
                    Value = param.Value
                };
                sqlParameters.Add(sqlParameter);
                query += " " + param.Name;
            }
            return context.Database.SqlQuery<T>(query, sqlParameters.ToArray()).ToList();
        }

        /// <summary>
        /// This method help to execute store procedure by store name and sql parameter
        /// </summary>
        /// <typeparam name="T">Object type return</typeparam>
        /// <param name="context">Database context</param>
        /// <param name="storeName">Store name for execution</param>
        /// <param name="parameters">Array of parameters</param>
        /// <returns>List result set after mapping</returns>
        public static List<T> ExcuteStoreProcedure<T>(this DbContext context, string storeName, params SqlParameter[] parameters) where T : class, new()
        {
            string query = storeName;
            foreach (SqlParameter param in parameters)
            {
                query += " " + param.ParameterName;
            }
            return context.Database.SqlQuery<T>(query, parameters).ToList();
        }
    }
}
