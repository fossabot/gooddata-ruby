# encoding: UTF-8
#
# Copyright (c) 2010-2015 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

module GoodData
  class AutomatedDataDistribution < Rest::Resource
    attr_accessor :output_stage

    def initialize(project)
      self.project = project
    end

    def process
      GoodData::Process[:all, project: self.project, client: self.project.client].find do |p|
        p.type == :dataload
      end
    end

    def create_output_stage(ads, client_id, output_stage_prefix)
      self.output_stage = GoodData::AdsOutputStage.create(ads: ads, project: self.project, client: self.project.client, client_id: client_id, output_stage_prefix: output_stage_prefix)
      self.output_stage
    end

  end
end