        if [ "$MONGO_INITDB_ROOT_USERNAME" ] && [ "$MONGO_INITDB_ROOT_PASSWORD" ]; then
            rootAuthDatabase='admin'

            "${mongo[@]}" "$rootAuthDatabase" <<-EOJS
                db.createUser({
                    user: $(_js_escape "$MONGO_INITDB_ROOT_USERNAME"),
                    pwd: $(_js_escape "$MONGO_INITDB_ROOT_PASSWORD"),
                    roles: [ { role: 'root', db: $(_js_escape "$rootAuthDatabase") } ]
                })
            EOJS
        fi