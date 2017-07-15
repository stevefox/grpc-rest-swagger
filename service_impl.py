import grpc
import time
from concurrent import futures
from service_pb2 import \
    StringMessage, \
    YourServiceServicer, \
    add_YourServiceServicer_to_server


_ONE_DAY_IN_SECONDS = 60*60*24


class YourService(YourServiceServicer):

    def Echo(self, request, context):
	return StringMessage(value="Hello world")


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    add_YourServiceServicer_to_server(YourService(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    try:
	while True:
	    time.sleep(_ONE_DAY_IN_SECONDS)
    except KeyboardInterrupt:
	server.stop(0)


if __name__ == '__main__':
    serve()
