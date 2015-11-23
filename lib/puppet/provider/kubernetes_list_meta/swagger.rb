require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_list_meta).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        selfLink: instance.selfLink.respond_to?(:to_hash) ? instance.selfLink.to_hash : instance.selfLink,
      
    
      
        resourceVersion: instance.resourceVersion.respond_to?(:to_hash) ? instance.resourceVersion.to_hash : instance.resourceVersion,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('list_meta', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('list_meta', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('list_meta', name)
  end

  private
  def self.list_instances
    list_instances_of('list_meta')
  end

  def build_params
    params = {
    
      
        selfLink: resource[:selfLink],
      
    
      
        resourceVersion: resource[:resourceVersion],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end