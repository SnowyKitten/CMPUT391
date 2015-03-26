CREATE INDEX descindex ON radiology_record(description) INDEXTYPE IS CTXSYS.CONTEXT;

CREATE INDEX diagindex ON radiology_record(diagnosis) INDEXTYPE IS CTXSYS.CONTEXT;

CREATE INDEX firstnindex ON persons(first_name) INDEXTYPE IS CTXSYS.CONTEXT;

CREATE INDEX lastnindex ON persons(last_name) INDEXTYPE IS CTXSYS.CONTEXT;



