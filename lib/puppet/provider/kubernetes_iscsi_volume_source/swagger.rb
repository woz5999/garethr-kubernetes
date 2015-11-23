require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_iscsi_volume_source).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        targetPortal: instance.targetPortal.respond_to?(:to_hash) ? instance.targetPortal.to_hash : instance.targetPortal,
      
    
      
        iqn: instance.iqn.respond_to?(:to_hash) ? instance.iqn.to_hash : instance.iqn,
      
    
      
        lun: instance.lun.respond_to?(:to_hash) ? instance.lun.to_hash : instance.lun,
      
    
      
        fsType: instance.fsType.respond_to?(:to_hash) ? instance.fsType.to_hash : instance.fsType,
      
    
      
        readOnly: instance.readOnly.respond_to?(:to_hash) ? instance.readOnly.to_hash : instance.readOnly,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('iscsi_volume_source', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('iscsi_volume_source', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('iscsi_volume_source', name)
  end

  private
  def self.list_instances
    list_instances_of('iscsi_volume_source')
  end

  def build_params
    params = {
    
      
        targetPortal: resource[:targetPortal],
      
    
      
        iqn: resource[:iqn],
      
    
      
        lun: resource[:lun],
      
    
      
        fsType: resource[:fsType],
      
    
      
        readOnly: resource[:readOnly],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end