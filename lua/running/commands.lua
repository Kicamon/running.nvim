return {
  ['c'] = {
    command = {
      'gcc "$filename" -o "$runfile"',
      './"$runfile"',
    },
  },
  ['cpp'] = {
    command = {
      'g++ "$filename" -std=c++17 -O2 -g -Wall -o "$runfile"',
      './"$runfile"',
    },
  },
  ['rust'] = {
    command = {
      'rustc "$filename"',
      './"$runfile"',
    },
  },
  ['python'] = {
    command = 'python3 "$filename"',
  },
  ['lua'] = {
    command = 'luajit "$filename"',
  },
  ['sh'] = {
    command = 'bash "$filename"',
  },
  ['javascript'] = {
    command = 'node "$filename"',
  },
  ['go'] = {
    command = 'go run "$filename"',
  },
  ['html'] = {
    command = 'live-server',
    modus = 'job',
  },
}