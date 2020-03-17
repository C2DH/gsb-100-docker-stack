FROM node:12-alpine as gsb-100-builder

WORKDIR /gsb-100

RUN apk add --no-cache git build-base python

COPY package.json yarn.lock ./

RUN yarn install

COPY public ./public
COPY src ./src

ENV NODE_ENV production
ENV NODE_OPTIONS --max_old_space_size=4096

RUN yarn run build

FROM busybox
WORKDIR /gsb-100
COPY --from=gsb-100-builder /gsb-100/build ./
