FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

#można z .env file pobrać, tutaj ustawiłem w taki sposób po prostu
ENV DJANGO_SUPERUSER_USERNAME=admin 
ENV DJANGO_SUPERUSER_EMAIL=admin@example.com
ENV DJANGO_SUPERUSER_PASSWORD=adminpassword
COPY . /app/

RUN python manage.py migrate && python manage.py createsuperuser --noinput || true

EXPOSE 8000
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver"]
