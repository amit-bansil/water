/*
 * ApplicationDescription.java CREATED: Aug 8, 2003 7:37:14 PM AUTHOR: Amit
 * Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.application.core;

import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.core.util.HelpReference;
import org.cps.framework.util.lang.misc.VersionNumber;
import org.cps.framework.util.resource.reader.DefaultReader;
import org.cps.framework.util.resource.reader.FormatReader;
import org.cps.framework.util.resource.reader.IconReader;
import org.cps.framework.util.resource.reader.IntReader;
import org.cps.framework.util.resource.reader.ObjectReader;
import org.cps.framework.util.resource.reader.StringArrayReader;
import org.cps.framework.util.resource.reader.URLReader;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import javax.swing.Icon;

import java.net.URL;
import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.util.Date;

/**
 * Describes an applications. name should be unique to an app. Other info can be
 * localized as needed. values for all keys in both application description and
 * basicdescription except full title and short title must be provided
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class ApplicationDescription extends BasicDescription{
    static{
        versionNumberReader=new DefaultReader<VersionNumber>(){
            protected VersionNumber _read(String data, String currentDirectory)
                    throws ParseException{
                return VersionNumber.parse(data);
            }
        };
    }
    private static final ObjectReader<VersionNumber> versionNumberReader;
    private final String[]            authors;
    private final String              buildAuthor;
    private final int                 buildNumber;
    private final URL                 contactURL, websiteURL;
    private final Date                date;
    private final HelpReference       helpRef;
    private final String              orgTitle, orgDesc;
    private final Icon                about;
    private final VersionNumber       version;

    public ApplicationDescription(ResourceAccessor res, String name){
        super(res,name,false);
        final ResourceAccessor data=getData();
        data.checkKey(BasicDescription.ICON_KEY);
        data.checkKey(BasicDescription.DESCRIPTION_KEY);
        orgTitle=data.getString("organization.title");
        orgDesc=data.getString("organization.description");
        buildAuthor=data.getString("build.author");
        authors=getData().getObject("authors",
                StringArrayReader.INSTANCE);
        version=getData().getObject("version",
                versionNumberReader);
        Format dateFormat=DateFormat.getDateTimeInstance(DateFormat.LONG,
                DateFormat.FULL);
        final ObjectReader<Date> dateFormatReader=new FormatReader<Date>(dateFormat);
        date=getData().getObject("date",dateFormatReader);
        buildNumber=getData().getObject("build.number",
                new IntReader(0,Integer.MAX_VALUE)).intValue();
        about=getData().getObject("about",IconReader.INSTANCE);
        contactURL=getData().getObject("contact",URLReader.INSTANCE);
        helpRef=getData().getObject("help",HelpReference.READER);
        websiteURL=getData().getObject("website",URLReader.INSTANCE);
    }

    public final Icon getAboutScreen(){
        return about;
    }

    public String[] getAuthors(){
        return authors;
    }

    public String getBuildAuthor(){
        return buildAuthor;
    }

    public int getBuildNumber(){
        return buildNumber;
    }

    public URL getContactURL(){
        return contactURL;
    }

    public final Date getDate(){
        return date;
    }

    public HelpReference getHelpReference(){
        return helpRef;
    }

    public String getOrganizationDescription(){
        return orgDesc;
    }

    public String getOrganizationTitle(){
        return orgTitle;
    }

    public final VersionNumber getVersion(){
        return version;
    }

    public final URL getWebsiteURL(){
        return websiteURL;
    }
}