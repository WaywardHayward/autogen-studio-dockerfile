FROM python:3.10-slim

COPY . /app
RUN pip install --upgrade pip

WORKDIR /app

EXPOSE 8081

# chown all the files to the app user
RUN useradd -m app
RUN chown -R app:app /app
USER app

RUN pip install --user app -r requirements.txt

RUN chown -R app:app /home/app/.local/
RUN chmod -R 755 /home/app/.local/bin/autogenstudio

# add autogenstudio to the PATH
ENV PATH="/home/app/.local/bin:${PATH}"

ENV OPENAI_API_KEY="your-key-here"

CMD [ "autogenstudio", "ui", "--host", "0.0.0.0", "--port", "8081"]