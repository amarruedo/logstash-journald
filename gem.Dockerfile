FROM jruby:1.7.21-jdk

WORKDIR /gem
RUN git clone https://github.com/stuart-warren/logstash-input-journald.git . \
    && git reset --hard c9d3eec887909ce5b9c3fba31c9054d8d0358b7e \
    && jgem build logstash-input-journald.gemspec \
    && mv logstash-input-journald-*.gem logstash-input-journald.gem 
    
RUN git clone https://github.com/logstash-plugins/logstash-output-loggly.git . \
    && jgem build logstash-output-loggly.gemspec \
    && mv logstash-output-loggly-*.gem logstash-output-loggly.gem \
