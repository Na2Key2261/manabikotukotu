class Public::EventsController < ApplicationController
  def index
    events = [
      {
        title: 'Event 1',
        start: '2024-02-21T10:00:00',
        end: '2024-02-21T12:00:00'
      },
      {
        title: 'Event 2',
        start: '2024-02-22T14:00:00',
        end: '2024-02-22T16:00:00'
      }
    ]

    render json: events
  end
end