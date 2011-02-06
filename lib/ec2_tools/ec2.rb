require 'AWS'

class Ec2Tools::EC2 < AWS::EC2::Base
  def servers
    unless @servers
      @servers = {}
      describe_instances.reservationSet.item.each do |reservation|
        reservation.instanceSet.item.each do |instance|
          if instance.instanceState.name == "running"
            key = instnacekeyName.to_sym
            @servers[key] = [] if @servers[key].nil?
            @servers[key] << instance
          end
        end
      end
    end
    @servers
  end
  
  def inspect
    "#<EC2>"
  end
end
