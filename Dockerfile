# Dùng image Maven đã tải (maven:3.8.1-ibmjava-8)
FROM maven:3.8.1-ibmjava-8

# Đặt thư mục làm việc trong container
WORKDIR /Project_01_SendEmail

# Copy toàn bộ project vào container
COPY . .

# Build project Maven (nếu bạn muốn tạo file jar)
RUN mvn clean package -DskipTests

FROM tomcat:9.0.111-jdk24-corretto
RUN rm -rf /usr/local/tomcat/webapps/* //xóa mặc định của tomcat
COPY --from=builder /Project_01_SendEmail/target/Project_01_SendEmail-1.0.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]