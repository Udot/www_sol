require "net/http"
require "net/https"
require 'json'

module GitHub
  extend self
  def self.org_public_members(org_name)
    code, response = get("/api/v2/json/organizations/#{org_name}/public_members")
    members = []
    if code.to_i == 200
      members_js = JSON.parse(response)
      members_js["users"].each do |user|
        # {"gravatar_id":"ccb2c36c776864ac4b821a155cc5de6b","company":"demental.info","name":"arnaud sellenet",
        # "created_at":"2011/04/10 23:05:28 -0700","location":"france","public_repo_count":16,"public_gist_count":0,
        # "blog":null,"following_count":0,"id":721659,"type":"User","permission":null,
        # "followers_count":0,"login":"demental","email":"arnodmental+github@gmail.com"}
        name = ""
        user["name"].split.each { |n| name += n.downcase.capitalize + " " }
        members << {"name" => name.chomp, "gravatar_id" => user["gravatar_id"], "login" => user['login']}
      end
    else
      members << {"name" => "nobody", "gravatar_id" => "", "login" => "nobody"}
    end
    return members
  end

  def self.pull_requests_people(org_name)
    code, response = get("/api/v2/json/organizations/#{org_name}/public_repositories")
    members = []
    if code.to_i == 200
      repos = []
      repositories = JSON.parse(response)
      repositories['repositories'].each do |repository|
        # {"open_issues":0,"has_issues":true,"description":"a ruby (bundler based) apps packager",
        # "forks":3,"created_at":"2011/09/01 06:58:33 -0700","fork":false,"organization":"Udot",
        # "has_downloads":true,"language":"Ruby","homepage":"","size":120,"private":false,
        # "name":"pinpin","watchers":5,"owner":"Udot","pushed_at":"2011/09/15 03:41:12 -0700",
        # "url":"https://github.com/Udot/pinpin","has_wiki":true}
        ['closed', 'open'].each do |state|
          code, response = get("/api/v2/json/pulls/Udot/#{repository['name']}/#{state}")
          if code.to_i == 200
            pulls = JSON.parse(response)["pulls"]
            if pulls.count > 0
              pulls.each do |pull|
                name = ""
                pull['user']['name'].split.each { |n| name += n.downcase.capitalize + " " }
                hash_u = {"name" => name, "login" => pull['user']["login"], "gravatar_id" => pull['user']['gravatar_id']}
                members << hash_u unless members.include?(hash_u)
              end
            end
          end
        end
      end
    else
      members << {"name" => "nobody", "gravatar_id" => "", "login" => "nobody"}
    end
    return members
  end

  private
  def get(request)
    http_r = Net::HTTP.new("github.com", 443)
    http_r.use_ssl = true
    response = nil
    begin
      http_r.start() do |http|
        req = Net::HTTP::Get.new(request)
        response = http.request(req)
      end
      return [response.code, response.body]
    rescue Errno::ECONNREFUSED
      return [503, "unavailable"]
    end
  end
end