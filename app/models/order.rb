class Order < ActiveRecord::Base
  include AASM

  PRICE = 35

  belongs_to :user
  belongs_to :menu_set
  belongs_to :group

  validates :user, :menu_set, presence: true
  validates :state, presence: true, inclusion: { in: %w[pending paid] }

  after_create :set_created_on

  delegate :name, :details, to: :menu_set, prefix: true
  delegate :email, to: :user, prefix: true

  scope :today, -> { where(created_on: Date.current) }
  scope :recent, -> { where('orders.created_on > ?', 5.days.ago ) }
  scope :removable, -> {
    if Freeze.frozen?
      none
    else
      where('orders.created_on > ?', Date.yesterday)
    end
  }

  aasm column: 'state' do
    state :pending, initial: true
    state :paid

    event :pay do
      transitions to: :paid
    end

    event :cancel_payment do
      transitions to: :pending
    end
  end

  def removable?
    created_on > Date.yesterday && !Freeze.frozen?
  end

  private

  def set_created_on
    update_column :created_on, self.created_at.to_date
  end
end
