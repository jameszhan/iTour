

require File.expand_path('../../../app/workers/crawler', __FILE__)

namespace :crawler do
  task :start do
    Resque.enqueue(Crawler, "Meituan", "food")   
  end
end