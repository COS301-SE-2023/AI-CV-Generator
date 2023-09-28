package com.revolvingSolutions.aicvgeneratorbackend.conf;

import org.hibernate.boot.model.relational.Namespace;
import org.hibernate.boot.model.relational.Sequence;
import org.hibernate.mapping.Table;
import org.hibernate.tool.schema.spi.SchemaFilter;
import org.hibernate.tool.schema.spi.SchemaFilterProvider;

public class Provider implements SchemaFilterProvider {
    @Override
    public SchemaFilter getCreateFilter() {
        return MySchemeFilter.instance;
    }

    @Override
    public SchemaFilter getDropFilter() {
        return MySchemeFilter.instance;
    }

    @Override
    public SchemaFilter getTruncatorFilter() {
        return MySchemeFilter.instance;
    }

    @Override
    public SchemaFilter getMigrateFilter() {
        return MySchemeFilter.instance;
    }

    @Override
    public SchemaFilter getValidateFilter() {
        return MySchemeFilter.instance;
    }
}

class MySchemeFilter implements SchemaFilter {

    public static  final MySchemeFilter instance = new MySchemeFilter();
    @Override
    public boolean includeNamespace(Namespace namespace) {
        return true;
    }

    @Override
    public boolean includeTable(Table table) {
        // This can be used to filter out entities as long as they are not used by another entity
        return true;
    }

    @Override
    public boolean includeSequence(Sequence sequence) {
        return true;
    }
}
