rake redis:start

QUEUE=crawler_queue rake environment resque:work


http://localhost:3000/tasks