<?php
/**
 * @package Newscoop
 * @copyright 2011 Sourcefabric o.p.s.
 * @license http://www.gnu.org/licenses/gpl-3.0.txt
 */

namespace Newscoop\Services;

/**
 * Event dispatcher service
 */
class EventDispatcherService extends \sfEventDispatcher
{
    /**
     * Set listeners
     *
     * @param object $container
     * @return void
     */
    public function setListeners($container)
    {
        if (!is_array($container->getParameter('listener'))) {
            return;
        }

        foreach ($container->getParameter('listener') as $listener) {
            $listenerParams = $container->getParameter($listener);
            if (!is_array($listenerParams['events'])) {
                continue;
            }

            foreach ($listenerParams['events'] as $eventName) {
                $this->connect($eventName, function($event) use ($container, $listener) {
                    $container->getService($listener)->update($event);
                });
            }
        }
    }

    /**
     * Set subscribers
     *
     * @param object $container
     * @return void
     */
    public function setSubscribers($container)
    {
        if (!is_array($container->getParameter('subscriber'))) {
            return;
        }

        foreach ($container->getParameter('subscriber') as $subscriber) {
            $class = $container->getServiceDefinition($subscriber)->getClass();
            foreach ($class::getSubscribedEvents() as $event => $method) {
                $this->connect($event, function($event) use ($container, $subscriber, $method) {
                    $container->getService($subscriber)->$method($event);
                });
            }
        }
    }
}
