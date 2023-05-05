FROM denoland/deno:1.33.1

# The port that your application listens to.
EXPOSE 8000

WORKDIR /app

RUN mkdir -p /home/deno && chown -R deno:deno /home/deno && mkdir /app/deno && chown -R deno:deno /app && mkdir -p /deno-dir && chown -R deno:deno /deno-dir

# Prefer not to run as root.
USER deno

# These steps will be re-run upon each file change in your working directory:
COPY --chown=deno:deno . deco

WORKDIR /app/deco

ENV DENO_DEPLOYMENT_ID=${GIT_REVISION}

RUN deno cache --lock-write main.ts

CMD ["run", "--cached-only", "-A", "main.ts"]
