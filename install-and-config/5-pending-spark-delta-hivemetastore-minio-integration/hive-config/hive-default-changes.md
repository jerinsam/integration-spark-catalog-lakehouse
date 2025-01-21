### Following properties are changed in hive-default.xml
```
<property>
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:postgresql://postgresdb:5432/hive_metastore</value>
</property>
<property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>org.postgresql.Driver</value>
</property>
<property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>jerin</value>
</property>
<property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value>jerinpostgresql</value>
</property>
<property>
    <name>hive.metastore.uris</name>
    <value>thrift://0.0.0.0:9083</value>  <!-- Use the appropriate hostname/IP and port -->
</property>

```