
#COPY --link --chown=${USER}:${USER} --from=vendor /usr/bin/composer /usr/bin/composer
COPY --link --chown=${USER}:${USER} composer.json ./
COPY --link --chown=${USER}:${USER} composer.lock ./


RUN composer install \
   --no-dev \
   --no-interaction \
   --no-autoloader \
   --no-ansi \
   --no-scripts

#RUN composer install \
#    --no-dev \
#    --no-interaction \
#    --no-autoloader \
#    --no-ansi \
#    --no-scripts \
#    --audit


COPY --link --chown=${USER}:${USER} . .

RUN mkdir -p \
   storage/framework/sessions \
   storage/framework/views \
   storage/framework/cache \
   storage/framework/testing \
   storage/logs \
   bootstrap/cache \
   && chmod -R 775 storage bootstrap/cache \
   && chown -R ${USER}:${USER} storage bootstrap/cache

   RUN composer install \
   --classmap-authoritative \
   --no-interaction \
   --no-ansi \
   --no-dev \
   && composer clear-cache

   RUN chmod -R 775 /var/www/html/storage
   RUN chown -R octane:octane /var/www/html/