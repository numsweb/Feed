require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include AASM
  aasm_column :state
 # no roles include Authorization::AasmRoles

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation
  
  aasm_initial_state :pending
  aasm_state :passive
  aasm_state :pending, :enter => [:make_activation_code]
  aasm_state :active,  :enter => :do_activate
  aasm_state :suspended, :enter => :do_suspend
  aasm_state :deleted, :enter => :do_delete
  aasm_state :rejected#, :enter => :do_reject # no do_reject method defined
  aasm_state :disabled, :enter => :do_disable

  aasm_event :register do
    transitions :from => :passive, :to => :pending, :guard => Proc.new {|u| !(u.crypted_password.blank? && u.password.blank?) }
  end
  aasm_event :activate do
    transitions :from => :pending, :to => :active
  end
  aasm_event :suspend do
    transitions :from => [:passive, :pending, :active], :to => :suspended
  end
  aasm_event :delete do
    transitions :from => [:passive, :pending, :active, :suspended], :to => :deleted
  end
  aasm_event :undelete do
    transitions :from => :deleted, :to => :passive
  end
  aasm_event :unsuspend do
    transitions :from => :suspended, :to => :active,  :guard => Proc.new {|u| !u.activated_at.blank? }
    transitions :from => :suspended, :to => :pending, :guard => Proc.new {|u| !u.email_confirmation_code.blank? }
    transitions :from => :suspended, :to => :passive
  end
  aasm_event :reject do
    transitions :from => [:active, :pending], :to => :rejected
  end
  aasm_event :disable do
      transitions :from => [:active, :pending, :passive, :suspended], :to => :disabled
  end



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def reset_password
    # First update the password_reset_code before setting the
    # reset_password flag to avoid duplicate mail notifications.
    update_attributes(:password_reset_code => nil)
    @reset_password = nil
  end

  # Used in user_observer
  def recently_forgot_password?
    @forgotten_password
  end

  # Used in user_observer
  def recently_reset_password?
    @reset_password
  end

  # Used in user_observer
  def recently_activated?
    @activated
  end
  
   def set_activation_code!
    self.make_activation_code
    self.save(false)
  end

 
 
  protected
    
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end
    
    def make_password_reset_code
      self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
    
    def do_activate
      @activated = true
      self.activated_at = Time.now.utc
      self.deleted_at = self.activation_code = nil
    end



end
