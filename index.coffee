optimist = require 'optimist'
exec = require 'exec'
config = require './config'

args = optimist.argv

validate_args = (args) ->
  unless args._.length > 0
    message 'screen_pos relative_coord [relative_pos] [-n]'
    process.exit()
  unless args._[1]
    args._[1] = 'under'
  if args.n
    args._[0] *= -1

message = (msg) ->
  console.log '\n  ' + msg + '\n'

make_xrandr_args = (main_pos, second_pos) ->
  args = ['xrandr']
  main_output = [
    '--output'
    config.screens.main.name
    '--auto'
    '--pos'
    main_pos.x + 'x' + main_pos.y
  ]
  second_output = [
    '--output'
    config.screens.second.name
    '--auto'
    '--pos'
    second_pos.x + 'x' + second_pos.y
  ]
  args.concat(main_output).concat(second_output)

get_main_pos = (val, pos, neg) ->
  switch pos
    when 'under'
      main_x = 0
      if val > 0
        main_x = val
      return {
        x: main_x
        y: config.screens.second.height
      }
    when 'above'
      main_x = 0
      if val > 0
        main_x = val
      return {
        x: main_x
        y: 0
      }
    when 'left'
      main_y = 0
      if val > 0
        main_y = val
      return {
        x: 0
        y: main_y
      }
    when 'right'
      main_y = 0
      if val > 0
        main_y = val
      return {
        x: config.screens.second.width
        y: main_y
      }

get_second_pos = (val, pos, neg) ->
  switch pos
    when 'under'
      second_x = 0
      if val < 0
        second_x = -1 * val
      return {
        x: second_x
        y: 0
      }
    when 'above'
      second_x = 0
      if val < 0
        second_x = -1 * val
      return {
        x: second_x
        y: config.screens.main.height
      }
    when 'left'
      second_y = 0
      if val < 0
        second_y = -1 * val
      return {
        x: config.screens.main.width
        y: second_y
      }
    when 'right'
      second_y = 0
      if val < 0
        second_y = -1 * val
      return {
        x: 0
        y: second_y
      }

start = ->
  validate_args args

  main_pos = get_main_pos args._[0], args._[1]
  second_pos = get_second_pos args._[0], args._[1]

  command = make_xrandr_args main_pos, second_pos

  message 'executing: ' + command.join ' '

  exec command, (error, stdout, stderr) ->
    if error
      message 'error ' + error
    if stderr
      message 'stderr ' + stderr

start()