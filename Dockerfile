FROM debian:latest

ENV VERSION_FRAMEWORK 1.5.1
ENV VERSION_WEBUI 0.5.12
ENV POSTGRES_HOST postgres
ENV POSTGRES_DATABASE arachni_production
ENV POSTGRES_USERNAME arachni
ENV POSTGRES_PASSWORD secret
ENV ARACHNI_REST_USER arachni
ENV ARACHNI_REST_PASS secret
ENV PATH /opt/arachni/bin:$PATH

RUN apt-get update && apt-get install -y curl

RUN	curl -#L https://github.com/Arachni/arachni/releases/download/v${VERSION_FRAMEWORK}/arachni-${VERSION_FRAMEWORK}-${VERSION_WEBUI}-linux-x86_64.tar.gz | tar zx && mv /arachni-$VERSION_FRAMEWORK-$VERSION_WEBUI /opt/arachni

ADD database.yml /opt/arachni/system/arachni-ui-web/config/database.yml

ADD scripts/startup.sh /startup.sh
RUN chmod u+x /startup.sh

EXPOSE 7331

CMD ["/startup.sh"]