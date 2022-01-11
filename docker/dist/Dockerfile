FROM node:16-alpine
#ARG NPM_TOKEN
ENV HOME_DIR "/home/node"
RUN echo "Running on $(uname -m)"
RUN apk add --no-cache build-base jq gcc wget git bash python3
RUN npm install -g typescript
USER node:node

COPY --chown=node:node . "${HOME_DIR}/app"
WORKDIR "${HOME_DIR}/app"

#RUN echo '//npm.pkg.github.com/:_authToken=${NPM_TOKEN}' >> "${HOME_DIR}/app/.npmrc"
RUN OP_GITHUB_ACCESS_TOKEN="" yarn install && \
OP_GITHUB_ACCESS_TOKEN="" yarn run build
#rm -rf node_modules

# RUN yarn install && yarn run build && \
# rm -rf node_modules

FROM node:16-alpine
ENV HOME_DIR "/home/node"

RUN npm install -g probot
USER node:node

COPY --chown=node:node --from=0 "${HOME_DIR}/app/packages" "${HOME_DIR}/app/packages"
COPY --chown=node:node --from=0 "${HOME_DIR}/app/package.json" "${HOME_DIR}/app/package.json"
#COPY --chown=node:node --from=0 "${HOME_DIR}/app/package-lock.json" "${HOME_DIR}/app/package-lock.json"
COPY --chown=node:node --from=0 "${HOME_DIR}/app/yarn.lock" "${HOME_DIR}/app/yarn.lock"
COPY --chown=node:node --from=0 "${HOME_DIR}/app/scripts" "${HOME_DIR}/app/scripts"
COPY --chown=node:node --from=0 "${HOME_DIR}/app/node_modules" "${HOME_DIR}/app/node_modules"
COPY --chown=node:node --from=0 "${HOME_DIR}/app/*.pem" "${HOME_DIR}/app/"
COPY --chown=node:node --from=0 "${HOME_DIR}/app/tmp" "${HOME_DIR}/app/tmp"

WORKDIR "${HOME_DIR}/app"
ENV PORT 3080
EXPOSE 3080
CMD yarn start
