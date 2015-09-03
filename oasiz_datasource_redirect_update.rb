# -*- coding: utf-8 -*-

require 'json'
require 'net/http'

Plugin.create(:oasiz_datasource_redirect_datasources) do

  settings("Redirect Update") do
      settings("基本設定") do
          multi("データソース名", :oasiz_datasource_redirect_datasources)
      end
  end

  on_boot do
    unless UserConfig[:oasiz_datasource_redirect_datasources]
      UserConfig[:oasiz_datasource_redirect_datasources] = []
    end
  end

  on_extract_receive_message { |datasource, messages|
      if UserConfig[:oasiz_datasource_redirect_datasources].include?(datasource.to_s)
        Plugin.call(:update, Service.primary, messages)
      end
  }

end
