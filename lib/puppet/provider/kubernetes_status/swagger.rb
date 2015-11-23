require 'puppet_x/puppetlabs/swagger/prefetch_error'
require 'puppet_x/puppetlabs/swagger/symbolize_keys'
require 'puppet_x/puppetlabs/kubernetes/provider'

Puppet::Type.type(:kubernetes_status).provide(:swagger, :parent => PuppetX::Puppetlabs::Kubernetes::Provider) do

  mk_resource_methods

  def self.instance_to_hash(instance)
    {
    ensure: :present,
    name: instance.metadata.name,
    
      
        kind: instance.kind.respond_to?(:to_hash) ? instance.kind.to_hash : instance.kind,
      
    
      
        apiVersion: instance.apiVersion.respond_to?(:to_hash) ? instance.apiVersion.to_hash : instance.apiVersion,
      
    
      
        metadata: instance.metadata.respond_to?(:to_hash) ? instance.metadata.to_hash : instance.metadata,
      
    
      
        status: instance.status.respond_to?(:to_hash) ? instance.status.to_hash : instance.status,
      
    
      
        message: instance.message.respond_to?(:to_hash) ? instance.message.to_hash : instance.message,
      
    
      
        reason: instance.reason.respond_to?(:to_hash) ? instance.reason.to_hash : instance.reason,
      
    
      
        details: instance.details.respond_to?(:to_hash) ? instance.details.to_hash : instance.details,
      
    
      
        code: instance.code.respond_to?(:to_hash) ? instance.code.to_hash : instance.code,
      
    
    object: instance,
    }
  end

  def create
    Puppet.info("Creating #{name}")
    create_instance_of('status', name, build_params)
  end

  def flush
    if ! @property_hash.empty? and @property_hash[:ensure] != :absent
      flush_instance_of('status', name, @property_hash[:object], build_params)
    end
  end

  def destroy
    Puppet.info("Deleting #{name}")
    destroy_instance_of('status', name)
  end

  private
  def self.list_instances
    list_instances_of('status')
  end

  def build_params
    params = {
    
      
        kind: resource[:kind],
      
    
      
        apiVersion: resource[:apiVersion],
      
    
      
        metadata: resource[:metadata],
      
    
      
        status: resource[:status],
      
    
      
        message: resource[:message],
      
    
      
        reason: resource[:reason],
      
    
      
        details: resource[:details],
      
    
      
        code: resource[:code],
      
    
    }
    params.delete_if { |key, value| value.nil? }
    params
  end
end