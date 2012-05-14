<?php

class Application_Plugin_ContentType extends Zend_Controller_Plugin_Abstract
{
    public function dispatchLoopShutdown()
    {
        $request = $this->getRequest();
        $response = $this->getResponse();

        $this->setContentType($response);

        switch ($request->getModuleName()) {
            case 'default':
                $response->setHeader('Cache-Control', 'public, max-age=3600', true);
                $response->setHeader('Pragma', 'cache', true);
                break;
        }
    }

    /**
     * Set content type if not set before
     *
     * @param Zend_Controller_Response_Abstract $response
     * @return void
     */
    private function setContentType(Zend_Controller_Response_Abstract $response)
    {
        // a workaround for wrongly set header here, when already being set (at theme export)
        if (isset($GLOBALS['header_content_type_set']) && $GLOBALS['header_content_type_set']) {
            return;
        }

        foreach ($response->getHeaders() as $header) {
            if (strtolower($header['name']) === 'content-type') {
                return;
            }
        }

        $response->setHeader('Content-Type', 'text/html; charset=utf-8');
    }
}
