assert  = require 'assert'
path    = require 'path'
os      = require 'os'
fs      = require 'fs'
fse     = require 'fs-extra'
zip     = require '..'
crypto  = require 'crypto'
exec    = require('child_process').exec

describe 'Tests', ->

  randomId = () ->
    return crypto.randomBytes(6).toString('hex')

  printArchivedFile = (archivePath, filePath, next) ->
    exec "unzip -p \"#{archivePath}\" \"#{filePath}\"", (err, stdout) ->
      next err, stdout
      return
    return

  it 'should archive file without root folder', (done) ->

    targetPath = path.join os.tmpdir(), randomId(), 'input'
    archivePath = path.join os.tmpdir(), randomId(), 'output-1.zip'

    helloFile = 'hello.txt'
    helloString = 'Hello Node'
    helloPath = path.join targetPath, helloFile

    # clean up
    fse.removeSync targetPath
    fse.removeSync archivePath

    # create folders
    fse.mkdirsSync targetPath
    fse.mkdirsSync path.dirname(archivePath)

    fs.writeFileSync helloPath, helloString

    options = 
      target: targetPath,
      excludeRoot: true

    zip archivePath, options, (err) ->
      assert.ifError err

      printArchivedFile archivePath, helloFile, (err, contents) ->
        assert.ifError err
        assert.equal contents, helloString
        done()
        return

      return
    return

  it 'should archive file with root folder', (done) ->

    inputDir = 'input'

    targetPath = path.join os.tmpdir(), randomId(), inputDir
    archivePath = path.join os.tmpdir(), randomId(), 'output-2.zip'

    helloFile = 'hello.txt'
    helloString = 'Hello Node'
    helloPath = path.join targetPath, helloFile

    # clean up
    fse.removeSync targetPath
    fse.removeSync archivePath
    
    # create folders
    fse.mkdirsSync targetPath
    fse.mkdirsSync path.dirname(archivePath)

    fs.writeFileSync helloPath, helloString

    options = 
      target: targetPath,
      excludeRoot: false

    zip archivePath, options, (err) ->
      assert.ifError err

      printArchivedFile archivePath, path.join(inputDir, helloFile), (err, contents) ->
        assert.ifError err
        assert.equal contents, helloString
        done()
        return

      return
    return

  return
