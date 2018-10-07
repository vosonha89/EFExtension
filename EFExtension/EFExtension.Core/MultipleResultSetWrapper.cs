using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;

namespace EFExtension.Core
{
    /// <summary>
    /// Wrapper help to get multiple result set from execute store procedure
    /// </summary>
    public class MultipleResultSetWrapper
    {
        private readonly DbContext _DbContext;
        private readonly string _StoredProcedure;
        private readonly SqlParameter[] _Parameters;
        private List<Func<IObjectContextAdapter, DbDataReader, IEnumerable>> ResultSets;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="db">Database context</param>
        /// <param name="storedName">Store name for execution</param>
        public MultipleResultSetWrapper(DbContext db, string storedName, SqlParameter[] parameters)
        {
            _DbContext = db;
            _StoredProcedure = storedName;
            _Parameters = parameters;
            ResultSets = new List<Func<IObjectContextAdapter, DbDataReader, IEnumerable>>();
        }

        /// <summary>
        /// Apply result set data to out datatype. Note : order by result set data in store procedure execution
        /// </summary>
        /// <typeparam name="TResult">Out datatype</typeparam>
        /// <returns>Wrapper</returns>
        public MultipleResultSetWrapper With<TResult>()
        {
            ResultSets.Add((adapter, reader) => adapter
                .ObjectContext
                .Translate<TResult>(reader)
                .ToList());

            return this;
        }

        /// <summary>
        /// Execute store procedure with multiple result set
        /// </summary>
        /// <returns>List data after mapping to out datatype</returns>
        public List<object> Execute()
        {
            List<object> results = new List<object>();
            _DbContext.Database.Connection.Open();
            DbCommand command = _DbContext.Database.Connection.CreateCommand();
            command.CommandText = "EXEC " + _StoredProcedure;
            if (_Parameters != null)
            {
                command.Parameters.AddRange(_Parameters);
                command.CommandText = command.CommandText + " " + string.Join(",", _Parameters.ToList());
            }
            using (var reader = command.ExecuteReader())
            {
                var adapter = ((IObjectContextAdapter)_DbContext);
                foreach (var resultSet in ResultSets)
                {
                    results.Add(resultSet(adapter, reader));
                    reader.NextResult();
                }
            }
            _DbContext.Database.Connection.Close();
            return results;
        }
    }
}
