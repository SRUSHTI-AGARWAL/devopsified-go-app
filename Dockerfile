FROM golang:1.23 as base

#setting the work directory
WORKDIR /app

#COPY go.mod to working directory
COPY go.mod ./

#RUN go mod download 
RUN go mod download

#Copy all source code to working directory
COPY . .


#Build the application 
RUN go build -o main .


#CMD ["./main"]
#=================================================
#Reducing build size
#using distroless image 

FROM gcr.io/distroless/base

#Copy the binary from previous stage
COPY --from=base /app/main .

#copy the static files from previous stage
COPY --from=base /app/static ./static

#expose the port on which application will run
EXPOSE 8080

#running the application
CMD ["./main"]
 
