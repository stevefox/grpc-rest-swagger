# swagger_client.YourServiceApi

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**echo**](YourServiceApi.md#echo) | **POST** /v1/example/echo |


# **echo**
> ExampleStringMessage echo(body)



### Example
```python
from __future__ import print_function
import time
import swagger_client
from swagger_client.rest import ApiException
from pprint import pprint

# create an instance of the API class
api_instance = swagger_client.YourServiceApi()
body = swagger_client.ExampleStringMessage() # ExampleStringMessage |

try:
    api_response = api_instance.echo(body)
    pprint(api_response)
except ApiException as e:
    print("Exception when calling YourServiceApi->echo: %s\n" % e)
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**ExampleStringMessage**](ExampleStringMessage.md)|  |

### Return type

[**ExampleStringMessage**](ExampleStringMessage.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)
