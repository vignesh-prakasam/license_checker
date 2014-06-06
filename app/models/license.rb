class License

  def today
    now = Date.today
    if $redis.hget("licenses", now).blank?
      licenses = (ApiUtils.licenses)
      $redis.hset("licenses", now, licenses)
      licenses
    else
      $redis.hget("licenses", now)
    end
  end

  def history
    $redis.hgetall("licenses")
  end

  def analyse
    all = Hash.from_xml(today)
    licensed_services = []
    if all
      p "===1======="
      all.each do |portal, licenses|
        p "======2==========="
        licenses.each do |service_list, service|
          p "=======3========="
          next if service.count < 5
          p service
          service.each do |s,s_type|
            next if !s_type.kind_of? Array  or s_type.count < 5
            p "========4==========="
            p s
            s_type.each do |final_service|
            new_service = Service.new
            new_service.name = final_service["name"]
            new_service.available = final_service["available"]
            new_service.licensed = final_service["licensed"]
            new_service.used = final_service["used"]
            new_service.service_type = s
            new_service.expiration_date = final_service["expiration_date"]
            new_service.used_by_hosted_users = final_service["used_by_hosted_users"]
            new_service.used_by_trunk_users =  final_service["used_by_trunk_users"]
            licensed_services.append(new_service)
            end
          end
        end
      end
    end

    p licensed_services
  end

end
