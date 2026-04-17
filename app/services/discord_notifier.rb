# Feature 6.1 - Discord Bot integration using discordrb-webhooks
# Sends booking confirmation notifications to Discord channel

class DiscordNotifier
  def self.booking_confirmed(order)
    webhook = Discordrb::Webhooks::Client.new(
      url: Rails.application.credentials.dig(:discord, :webhook_url)
    )

    webhook.execute do |builder|
      builder.add_embed do |embed|
        embed.title       = "🏨 New Booking Confirmed!"
        embed.description = "A new room booking has been placed at Winnipeg Comfort Hotels."
        embed.colour      = 0xB8965A
        embed.timestamp   = Time.now

        embed.add_field(name: "Order #",   value: order.id.to_s,          inline: true)
        embed.add_field(name: "Customer",  value: order.user.name,         inline: true)
        embed.add_field(name: "Total",     value: "$#{order.total}",       inline: true)
        embed.add_field(name: "Status",    value: order.status.capitalize, inline: true)
        embed.add_field(name: "Province",  value: order.province_name,     inline: true)
        embed.add_field(name: "Rooms",     value: order.order_items.map(&:room_name).join(", "), inline: false)

        embed.footer = Discordrb::Webhooks::EmbedFooter.new(
          text: "Winnipeg Comfort Hotels Booking System"
        )
      end
    end
  rescue StandardError => e
    Rails.logger.error "Discord notification failed: #{e.message}"
  end
end