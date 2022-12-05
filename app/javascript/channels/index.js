// Import all the channels to be used by Action Cable
import "./search_channel"
App.cable = ActionCable.createConsumer("/cable")