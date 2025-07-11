FROM nginx:latest

RUN rm -rf /usr/share/nginx/html/*

COPY index.html /usr/share/nginx/html/
COPY StudentSurvey.html /usr/share/nginx/html/
COPY gmu_map.png /usr/share/nginx/html/
COPY jmu_map.png /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
