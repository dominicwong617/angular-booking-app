@Guru.controller "CalendarController", [
  "$scope"
  "CalendarService"
  ($scope, CalendarService) ->

    $scope.timeline = null

    $scope.setDate = (date) ->
      $scope.timeline.moveTo moment(date).format("YYYY-MM-DD") if $scope.timeline

    $scope.setWindow = (start, end) ->
      $scope.timeline.setWindow
        start : start
        end   : end

    $scope.generateCalendar = (defaultDate=moment().format()) ->
      CalendarService.generateCalendarData().then (dataNodes) ->
        options =
          minHeight: "300px"
          locale: "en"
          orientation: "top"
          zoomMin: 12500000
          zoomMax: 604800000

        $scope.timeline = new vis.Timeline(
          document.getElementById("appointments-calendar"),
          new vis.DataSet(dataNodes.data),
          dataNodes.groups,
          options
        )
        $scope.setDate defaultDate
        $scope.setWindow 1416239702159, 1416313238094

    $scope.zoom = (percentage) ->
      range    = $scope.timeline.getWindow()
      interval = range.end - range.start
      start    = range.start.valueOf() - interval * percentage
      end      = range.end.valueOf()   + interval * percentage

      $scope.setWindow start, end

    $scope.pickADateOptions =
      format: "d mmmm yyyy"
      min: moment().format()
      onSet: (context) ->
        $scope.setDate context.select

    $scope.generateCalendar()

    $scope.$on "appointment-created", (ev, appointment) ->
      $("#appointments-calendar").empty()
      #TODO: Maybe just push the appointment and re-generate the graph?
      $scope.generateCalendar appointment.date

  ]