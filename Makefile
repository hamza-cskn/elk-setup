ELASTIC_PASSWORD ?= changeme

up:
	ELASTIC_PASSWORD=$(ELASTIC_PASSWORD) docker compose up -d
	@echo "⏳  Elasticsearch’in gelmesini bekliyorum..."
	@until docker compose exec -T elasticsearch curl -s -k https://localhost:9200 >/dev/null 2>&1; do sleep 2; done
	@docker compose cp elasticsearch:/usr/share/elasticsearch/config/certs/ca/ca.crt ./ca.crt
	@echo "✅  CA sertifikası ./ca.crt dosyasına kopyalandı."

down:
	docker compose down -v