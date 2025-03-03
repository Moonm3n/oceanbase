# package_name : dbms_stats_mysql
# author : jiangxiu.wt

create or replace PACKAGE dbms_stats AUTHID CURRENT_USER

    DECLARE DEFAULT_METHOD_OPT     VARCHAR(1) DEFAULT 'Z';
    DECLARE DEFAULT_GRANULARITY    VARCHAR(1) DEFAULT 'Z';
    DECLARE AUTO_SAMPLE_SIZE       DECIMAL DEFAULT 0;
    DECLARE DEFAULT_STAT_CATEGORY  VARCHAR(20) DEFAULT 'OBJECT_STATS';

    PROCEDURE gather_table_stats (
      ownname            VARCHAR(65535),
      tabname            VARCHAR(65535),
      partname           VARCHAR(65535) DEFAULT NULL,
      estimate_percent   DECIMAL DEFAULT AUTO_SAMPLE_SIZE,
      block_sample       BOOLEAN DEFAULT FALSE,
      method_opt         VARCHAR(65535) DEFAULT DEFAULT_METHOD_OPT,
      degree             DECIMAL DEFAULT NULL,
      granularity        VARCHAR(65535) DEFAULT DEFAULT_GRANULARITY,
      cascade            BOOLEAN DEFAULT NULL,
      stattab            VARCHAR(65535) DEFAULT NULL,
      statid             VARCHAR(65535) DEFAULT NULL,
      statown            VARCHAR(65535) DEFAULT NULL,
      no_invalidate      BOOLEAN DEFAULT FALSE,
      stattype           VARCHAR(65535) DEFAULT 'DATA',
      force              BOOLEAN DEFAULT FALSE
    );

    PROCEDURE gather_schema_stats (
      ownname            VARCHAR(65535),
      estimate_percent   DECIMAL DEFAULT AUTO_SAMPLE_SIZE,
      block_sample       BOOLEAN DEFAULT FALSE,
      method_opt         VARCHAR(65535) DEFAULT DEFAULT_METHOD_OPT,
      degree             DECIMAL DEFAULT NULL,
      granularity        VARCHAR(65535) DEFAULT DEFAULT_GRANULARITY,
      cascade            BOOLEAN DEFAULT NULL,
      stattab            VARCHAR(65535) DEFAULT NULL,
      statid             VARCHAR(65535) DEFAULT NULL,
      statown            VARCHAR(65535) DEFAULT NULL,
      no_invalidate      BOOLEAN DEFAULT FALSE,
      stattype           VARCHAR(65535) DEFAULT 'DATA',
      force              BOOLEAN DEFAULT FALSE
    );

    PROCEDURE gather_index_stats (
      ownname            VARCHAR(65535),
      indname            VARCHAR(65535),
      partname           VARCHAR(65535) DEFAULT NULL,
      estimate_percent   DECIMAL DEFAULT AUTO_SAMPLE_SIZE,
      stattab            VARCHAR(65535) DEFAULT NULL,
      statid             VARCHAR(65535) DEFAULT NULL,
      statown            VARCHAR(65535) DEFAULT NULL,
      degree             DECIMAL DEFAULT NULL,
      granularity        VARCHAR(65535) DEFAULT DEFAULT_GRANULARITY,
      no_invalidate      BOOLEAN DEFAULT FALSE,
      force              BOOLEAN DEFAULT FALSE,
      tabname            VARCHAR(65535) DEFAULT NULL
    );

    PROCEDURE set_table_stats (
      ownname            VARCHAR(65535),
      tabname            VARCHAR(65535),
      partname           VARCHAR(65535) DEFAULT NULL,
      stattab            VARCHAR(65535) DEFAULT NULL,
      statid             VARCHAR(65535) DEFAULT NULL,
      numrows            DECIMAL DEFAULT NULL,
      numblks            DECIMAL DEFAULT NULL,
      avgrlen            DECIMAL DEFAULT NULL,
      flags              DECIMAL DEFAULT NULL,
      statown            VARCHAR(65535) DEFAULT NULL,
      no_invalidate      BOOLEAN DEFAULT FALSE,
      cachedblk          DECIMAL DEFAULT NULL,
      cachehit           DECIMAL DEFAULT NULL,
      force              BOOLEAN DEFAULT FALSE,
      nummacroblks       DECIMAL DEFAULT NULL,
      nummicroblks       DECIMAL DEFAULT NULL
    );

    PROCEDURE set_column_stats (
      ownname            VARCHAR(65535),
      tabname            VARCHAR(65535),
      colname            VARCHAR(65535),
      partname           VARCHAR(65535) DEFAULT NULL,
      stattab            VARCHAR(65535) DEFAULT NULL,
      statid             VARCHAR(65535) DEFAULT NULL,
      distcnt            DECIMAL DEFAULT NULL,
      density            DECIMAL DEFAULT NULL,
      nullcnt            DECIMAL DEFAULT NULL,
      epc                DECIMAL DEFAULT NULL,
      minval             TEXT DEFAULT NULL,
      maxval             TEXT DEFAULT NULL,
      bkvals             TEXT DEFAULT NULL,
      novals             TEXT DEFAULT NULL,
      chvals             TEXT DEFAULT NULL,
      eavals             TEXT DEFAULT NULL,
      rpcnts             TEXT DEFAULT NULL,
      eavs               DECIMAL DEFAULT NULL,
      avgclen            DECIMAL DEFAULT NULL,
      flags              DECIMAL DEFAULT NULL,
      statown            VARCHAR(65535) DEFAULT NULL,
      no_invalidate      BOOLEAN DEFAULT FALSE,
      force              BOOLEAN DEFAULT FALSE
    );

    PROCEDURE set_index_stats (
      ownname            VARCHAR(65535),
      indname            VARCHAR(65535),
      partname           VARCHAR(65535) DEFAULT NULL,
      stattab            VARCHAR(65535) DEFAULT NULL,
      statid             VARCHAR(65535) DEFAULT NULL,
      numrows            DECIMAL    DEFAULT NULL,
      numlblks           DECIMAL    DEFAULT NULL,
      numdist            DECIMAL    DEFAULT NULL,
      avglblk            DECIMAL    DEFAULT NULL,
      avgdblk            DECIMAL    DEFAULT NULL,
      clstfct            DECIMAL    DEFAULT NULL,
      indlevel           DECIMAL    DEFAULT NULL,
      flags              DECIMAL    DEFAULT NULL,
      statown            VARCHAR(65535) DEFAULT NULL,
      no_invalidate      BOOLEAN    DEFAULT FALSE,
      guessq             DECIMAL    DEFAULT NULL,
      cachedblk          DECIMAL    DEFAULT NULL,
      cachehit           DECIMAL    DEFAULT NULL,
      force              BOOLEAN    DEFAULT FALSE,
      avgrlen            DECIMAL    DEFAULT NULL,
      nummacroblks       DECIMAL    DEFAULT NULL,
      nummicroblks       DECIMAL    DEFAULT NULL,
      tabname            VARCHAR(65535) DEFAULT NULL
    );

    PROCEDURE delete_table_stats (
      ownname           VARCHAR(65535),
      tabname           VARCHAR(65535),
      partname          VARCHAR(65535) DEFAULT NULL,
      stattab           VARCHAR(65535) DEFAULT NULL,
      statid            VARCHAR(65535) DEFAULT NULL,
      cascade_parts     BOOLEAN DEFAULT TRUE,
      cascade_columns   BOOLEAN DEFAULT TRUE,
      cascade_indexes   BOOLEAN DEFAULT TRUE,
      statown           VARCHAR(65535) DEFAULT NULL,
      no_invalidate     BOOLEAN DEFAULT FALSE,
      force             BOOLEAN DEFAULT FALSE,
      degree            DECIMAL DEFAULT 1
    );

    PROCEDURE delete_column_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      colname          VARCHAR(65535),
      partname         VARCHAR(65535) DEFAULT NULL,
      stattab          VARCHAR(65535) DEFAULT NULL,
      statid           VARCHAR(65535) DEFAULT NULL,
      cascade_parts    BOOLEAN DEFAULT TRUE,
      statown          VARCHAR(65535) DEFAULT NULL,
      no_invalidate    BOOLEAN DEFAULT FALSE,
      force            BOOLEAN DEFAULT FALSE,
      col_stat_type    VARCHAR(65535) DEFAULT 'ALL',
      degree           DECIMAL DEFAULT 1
    );

    procedure delete_index_stats(
      ownname          VARCHAR(65535),
      indname          VARCHAR(65535),
      partname         VARCHAR(65535) DEFAULT NULL,
      stattab          VARCHAR(65535) DEFAULT NULL,
      statid           VARCHAR(65535) DEFAULT NULL,
      cascade_parts    BOOLEAN        DEFAULT TRUE,
      statown          VARCHAR(65535) DEFAULT NULL,
      no_invalidate    BOOLEAN        DEFAULT FALSE,
      stattype         VARCHAR(65535) DEFAULT 'ALL',
      force            BOOLEAN        DEFAULT FALSE,
      tabname          VARCHAR(65535) DEFAULT NULL,
      degree           DECIMAL DEFAULT 1
    );

    PROCEDURE delete_schema_stats (
      ownname           VARCHAR(65535),
      stattab           VARCHAR(65535) DEFAULT NULL,
      statid            VARCHAR(65535) DEFAULT NULL,
      statown           VARCHAR(65535) DEFAULT NULL,
      no_invalidate     BOOLEAN DEFAULT FALSE,
      force             BOOLEAN DEFAULT FALSE,
      degree            DECIMAL DEFAULT 1
    );

    PROCEDURE FLUSH_DATABASE_MONITORING_INFO();
    PROCEDURE GATHER_DATABASE_STATS_JOB_PROC(duration BIGINT DEFAULT NULL);

    PROCEDURE create_stat_table(
      ownname          VARCHAR(65535),
      stattab          VARCHAR(65535),
      tblspace         VARCHAR(65535) DEFAULT NULL,
      global_temporary BOOLEAN DEFAULT FALSE
    );

    PROCEDURE drop_stat_table(
      ownname VARCHAR(65535),
      stattab VARCHAR(65535)
    );

    PROCEDURE export_table_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      partname         VARCHAR(65535) DEFAULT NULL,
      stattab          VARCHAR(65535),
      statid           VARCHAR(65535) DEFAULT NULL,
      cascade          BOOLEAN DEFAULT TRUE,
      statown          VARCHAR(65535) DEFAULT NULL,
      stat_category    VARCHAR(65535) DEFAULT DEFAULT_STAT_CATEGORY
    );

    PROCEDURE export_column_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      colname          VARCHAR(65535),
      partname         VARCHAR(65535) DEFAULT NULL,
      stattab          VARCHAR(65535),
      statid           VARCHAR(65535) DEFAULT NULL,
      statown          VARCHAR(65535) DEFAULT NULL
    );

    PROCEDURE export_schema_stats (
      ownname          VARCHAR(65535),
      stattab          VARCHAR(65535),
      statid           VARCHAR(65535) DEFAULT NULL,
      statown          VARCHAR(65535) DEFAULT NULL
    );

    PROCEDURE export_index_stats (
      ownname           VARCHAR(65535),
      indname           VARCHAR(65535),
      partname          VARCHAR(65535) DEFAULT NULL,
      stattab           VARCHAR(65535),
      statid            VARCHAR(65535) DEFAULT NULL,
      statown           VARCHAR(65535) DEFAULT NULL,
      tabname           VARCHAR(65535) DEFAULT NULL
    );

    PROCEDURE import_table_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      partname         VARCHAR(65535) DEFAULT NULL,
      stattab          VARCHAR(65535),
      statid           VARCHAR(65535) DEFAULT NULL,
      cascade          BOOLEAN DEFAULT TRUE,
      statown          VARCHAR(65535) DEFAULT NULL,
      no_invalidate    BOOLEAN DEFAULT FALSE,
      force            BOOLEAN DEFAULT FALSE,
      stat_category    VARCHAR(65535) DEFAULT DEFAULT_STAT_CATEGORY
    );

    PROCEDURE import_column_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      colname          VARCHAR(65535),
      partname         VARCHAR(65535) DEFAULT NULL,
      stattab          VARCHAR(65535),
      statid           VARCHAR(65535) DEFAULT NULL,
      statown          VARCHAR(65535) DEFAULT NULL,
      no_invalidate    BOOLEAN DEFAULT FALSE,
      force            BOOLEAN DEFAULT FALSE
    );

   PROCEDURE import_schema_stats (
      ownname          VARCHAR(65535),
      stattab          VARCHAR(65535),
      statid           VARCHAR(65535) DEFAULT NULL,
      statown          VARCHAR(65535) DEFAULT NULL,
      no_invalidate    BOOLEAN DEFAULT FALSE,
      force            BOOLEAN DEFAULT FALSE
    );

    PROCEDURE import_index_stats (
      ownname          VARCHAR(65535),
      indname          VARCHAR(65535),
      partname         VARCHAR(65535) DEFAULT NULL,
      stattab          VARCHAR(65535),
      statid           VARCHAR(65535) DEFAULT NULL,
      statown          VARCHAR(65535) DEFAULT NULL,
      no_invalidate    BOOLEAN DEFAULT FALSE,
      force            BOOLEAN DEFAULT FALSE,
      tabname          VARCHAR(65535) DEFAULT NULL
    );

    PROCEDURE lock_table_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      stattype         VARCHAR(65535) DEFAULT 'ALL'
    );

    PROCEDURE lock_partition_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      partname         VARCHAR(65535)
    );

    PROCEDURE lock_schema_stats(
      ownname          VARCHAR(65535),
      STATTYPE         VARCHAR(65535) DEFAULT 'ALL'
    );

    PROCEDURE unlock_table_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      stattype         VARCHAR(65535) DEFAULT 'ALL'
    );

    PROCEDURE unlock_partition_stats (
      ownname          VARCHAR(65535),
      tabname          VARCHAR(65535),
      partname         VARCHAR(65535)
    );

    PROCEDURE unlock_schema_stats(
      ownname          VARCHAR(65535),
      STATTYPE         VARCHAR(65535) DEFAULT 'ALL'
    );

    PROCEDURE restore_table_stats (
      ownname               VARCHAR(65535),
      tabname               VARCHAR(65535),
      as_of_timestamp       DATETIME(6),
      restore_cluster_index BOOLEAN DEFAULT FALSE,
      force                 BOOLEAN DEFAULT FALSE,
      no_invalidate         BOOLEAN DEFAULT FALSE
    );

    PROCEDURE restore_schema_stats (
      ownname               VARCHAR(65535),
      as_of_timestamp       DATETIME(6),
      force                 BOOLEAN DEFAULT FALSE,
      no_invalidate         BOOLEAN DEFAULT FALSE
    );

    PROCEDURE purge_stats(
      before_timestamp      DATETIME(6)
    );

    PROCEDURE alter_stats_history_retention(
      retention             DECIMAL
    );

    FUNCTION get_stats_history_availability() RETURN DATETIME(6);

    FUNCTION get_stats_history_retention() RETURN DECIMAL;

    PROCEDURE reset_global_pref_defaults();

    PROCEDURE reset_param_defaults();

    PROCEDURE set_global_prefs(
      pname         VARCHAR(65535),
      pvalue        VARCHAR(65535)
    );

    PROCEDURE set_param(
      pname          VARCHAR(65535),
      pval           VARCHAR(65535)
    );

    PROCEDURE set_schema_prefs(
      ownname        VARCHAR(65535),
      pname          VARCHAR(65535),
      pvalue         VARCHAR(65535)
    );

    PROCEDURE set_table_prefs(
      ownname        VARCHAR(65535),
      tabname        VARCHAR(65535),
      pname          VARCHAR(65535),
      pvalue         VARCHAR(65535)
    );

    FUNCTION get_prefs (
      pname           VARCHAR(65535),
      ownname         VARCHAR(65535) DEFAULT NULL,
      tabname         VARCHAR(65535) DEFAULT NULL
    ) RETURN VARCHAR(65535);

    FUNCTION get_param (
      pname           VARCHAR(65535)
    )RETURN VARCHAR(65535);

    PROCEDURE delete_schema_prefs(
      ownname        VARCHAR(65535),
      pname          VARCHAR(65535)
    );

    PROCEDURE delete_table_prefs (
      ownname        VARCHAR(65535),
      tabname        VARCHAR(65535),
      pname          VARCHAR(65535)
    );

    PROCEDURE copy_table_stats (
      ownname        VARCHAR(65535),
      tabname        VARCHAR(65535),
      srcpartname    VARCHAR(65535),
      dstpartname		 VARCHAR(65535),
      scale_factor	 DECIMAL DEFAULT 1,
      flags					 DECIMAL DEFAULT NULL,
      force          BOOLEAN DEFAULT FALSE
    );

    PROCEDURE cancel_gather_stats (
      taskid          VARCHAR(65535)
    );
    PROCEDURE GATHER_SYSTEM_STATS();

    PROCEDURE DELETE_SYSTEM_STATS();

    PROCEDURE SET_SYSTEM_STATS (
      pname          VARCHAR(65535),
      pvalue         DECIMAL
    );

END dbms_stats;
