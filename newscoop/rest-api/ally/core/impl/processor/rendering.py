'''
Created on Jun 30, 2011

@package: Newscoop
@copyright: 2011 Sourcefabric o.p.s.
@license: http://www.gnu.org/licenses/gpl-3.0.txt
@author: Gabriel Nistor

Provides the rendering for a render request.
'''

from ally.core.spec.presenting import Renders
from ally.core.spec.server import Processor, ProcessorsChain, Request, Response
from ally.core.util import injected
import logging

# --------------------------------------------------------------------

log = logging.getLogger(__name__)

# --------------------------------------------------------------------

@injected
class RenderingHandler(Processor):
    '''
    Implementation for a processor that provides the rendering for a render request.
    '''
    
    renders = Renders
    # The renders to be used by this rendering handler.
    
    def __init__(self):
        assert isinstance(self.renders, Renders), 'Invalid Renders object %s' % self.renders
    
    def process(self, req, rsp, chain):
        '''
        @see: Processor.process
        '''
        assert isinstance(req, Request), 'Invalid request %s' % req
        assert isinstance(rsp, Response), 'Invalid response %s' % rsp
        assert isinstance(chain, ProcessorsChain), 'Invalid processors chain %s' % chain
        log.debug('Rendering object of type %s to encoder %s', req.objType, rsp.encoder)
        self.renders.render(req.obj, req.objType, rsp.encoder)
        chain.process(req, rsp)
