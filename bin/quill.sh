#! /bin/sh

cd `dirname $0`/..
exec bundle exec ruby -I lib bin/quill.rb $@