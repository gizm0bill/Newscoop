'''
Created on Jun 28, 2011

@package: Newscoop
@copyright: 2011 Sourcefabric o.p.s.
@license: http://www.gnu.org/licenses/gpl-3.0.txt
@author: Gabriel Nistor

Provides the URI request path handler.
'''

from ally.core.internationalization import msg as _
from ally.core.spec.codes import RESOURCE_NOT_FOUND, RESOURCE_FOUND, \
    UNKNOWN_FORMAT
from ally.core.spec.resources import Converter, Path, ResourcesManager
from ally.core.spec.server import Response, Processor, ProcessorsChain
from ally.core.util import injected, findInValues
from cgi import parse_qsl
from urllib.parse import urlencode, urlparse, urlunsplit
import logging
from ally.core.spec.presenting import EncoderPath
from ally.http.spec import RequestHTTP

# --------------------------------------------------------------------

log = logging.getLogger(__name__)

# --------------------------------------------------------------------

@injected
class URIHandler(Processor):
    '''
    Implementation for a processor that provides the URI conversion to a resource path.
    '''
    
    contentTypes = dict
    # The content types map.
    resourcesManager = ResourcesManager
    # The resources manager that will provide the path to the resource node.
    converter = Converter
    # The default content type to be used if none is detected on the URI
    scheme = 'http'
    # The scheme of the uri
    netloc = str
    # The path domain something like "localhost".
    
    def __init__(self):
        assert isinstance(self.contentTypes, dict), 'Invalid content types dictionary %s' % self.contentTypes
        assert isinstance(self.resourcesManager, ResourcesManager), \
        'Invalid resources manager %s' % self.resourcesManager
        assert isinstance(self.converter, Converter), 'Invalid Converter object %s' % self.converter
        assert isinstance(self.scheme, str), 'Invalid string %s' % self.scheme
        assert isinstance(self.netloc, str), 'Invalid string %s' % self.netloc

    def process(self, req, rsp, chain):
        '''
        @see: Processor.process
        '''
        assert isinstance(req, RequestHTTP), 'Invalid HTTP request %s' % req
        assert isinstance(rsp, Response), 'Invalid response %s' % rsp
        assert isinstance(chain, ProcessorsChain), 'Invalid processors chain %s' % chain
        url = urlparse(req.path)
        paths = url.path.split('/')
        i = paths[-1].rfind('.')
        if i < 0:
            extension = None
        else:
            extension = paths[-1][i + 1:].lower()
            paths[-1] = paths[-1][0:i]
        paths = [p for p in paths if len(p) != 0]
        params = parse_qsl(url.query, True, False)
        resourcePath = self.resourcesManager.findResourcePath(self.converter, paths)
        assert isinstance(resourcePath, Path)
        if resourcePath.node is None:
            # we stop the chain processing
            rsp.setCode(RESOURCE_NOT_FOUND, _('Cannot find resources for path'))
            log.debug('Could not locate resource for %s', req.path)
            return
        else:
            rsp.code = RESOURCE_FOUND
            req.resourcePath = resourcePath
            req.params = params
            if extension is not None:
                contentType = findInValues(self.contentTypes, extension)
                if contentType is None:
                    rsp.setCode(UNKNOWN_FORMAT, _('Invalid format ($1)', extension))
                    log.debug('Unable to find a content type for format %s', extension)
                    return
            else:
                contentType = req.accContentTypes[0]
            rsp.contentType = contentType
            rsp.encoderPath = EncoderPathURI(self, extension)
            log.debug('Successfully found resource for path %s with extension %s', req.path, extension)
        rsp.charSet = req.accCharSets[0]
        chain.process(req, rsp)
            
# --------------------------------------------------------------------

class EncoderPathURI(EncoderPath):
    '''
    Provides encoding for the URI paths generated by the URI processor.
    '''
    
    def __init__(self, uri, ext):
        '''
        @param uri: URI
            The URI processor of the encoder path.
        @param ext: string
            The extension to use on the encoded paths.
        '''
        assert isinstance(uri, URIHandler), 'Invalid URI handler %s' % uri
        assert ext is None or isinstance(ext, str), 'Invalid extension %s' % ext
        self._uri = uri
        self._ext = ext

    def encode(self, path, parameters=None):
        '''
        @see: EncoderPath.encode
        '''
        assert isinstance(path, Path), 'Invalid path %s' % path
        uri = self._uri
        assert isinstance(uri, URIHandler)
        paths = path.asPaths(uri.converter)
        if path.node.isGroup: paths.append('')
        if self._ext is not None: paths.append('.' + self._ext)
        query = urlencode(parameters) if parameters is not None else ''
        return urlunsplit((uri.scheme, uri.netloc, '/'.join(paths), query, ''))
 
