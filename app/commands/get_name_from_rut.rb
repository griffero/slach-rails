class GetNameFromRut < PowerTypes::Command.new(:rut, force_update: false)
  ORACLE_HOST = ENV.fetch('ORACLE_HOST', 'https://fintoc-oracle.herokuapp.com/')

  def perform
    path = "#{ORACLE_HOST}api/v1/get_entity_by_rut?rut=#{@rut}&update=#{@force_update}"
    response = HTTParty.get(path)
    name = response&.parsed_response&.dig('entity', 'name')
    return name if name.present?

    logger.info "Rut #{@rut} not found in the Oracle"
    nil
  end
end
